# frozen_string_literal: false

require_relative 'spec_helper.rb'

describe 'Tests Api functionality' do
  API_VER = 'api/v0.1'.freeze
  #CASSETTE_FILE = 'nba_stats_api'.freeze

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Game information' do
    before do
      app.DB[:gameinfos].delete
      app.DB[:players].delete
      app.DB[:schedules].delete
    end

    describe 'POSTting to create entities from MySportsFeeds',:order => :defined do

      it 'HAPPY: should retrieve and store game info and player performance' do
        post "#{API_VER}/game_info/#{SEASON}/#{GAMEID}"
        _(last_response.status).must_equal 201
        _(last_response.header['Location'].size).must_be :>, 0
        game_data = JSON.parse last_response.body
        _(game_data.size).must_be :>, 0
      end

      it 'SAD: should report error if no Game Played found' do
        post "#{API_VER}/game_info/#{SEASON}/GGGameId"
        _(last_response.status).must_equal 400
      end

      it 'BAD: should report error if duplicate Game Info found' do
        post "#{API_VER}/game_info/#{SEASON}/#{GAMEID}"
        _(last_response.status).must_equal 201
        post "#{API_VER}/game_info/#{SEASON}/#{GAMEID}"
        _(last_response.status).must_equal 409
      end


      it 'HAPPY: should retrieve and store player info' do
        post "#{API_VER}/player_info/#{SEASON}/#{GAMEID}"
        _(last_response.status).must_equal 201
        _(last_response.header['Location'].size).must_be :>, 0
        player_data = JSON.parse last_response.body
        _(player_data.size).must_be :>, 0
      end

      it 'HAPPY: should retrieve and store schedule info' do
        post "#{API_VER}/schedule/#{SEASON}/#{DATE}"
        _(last_response.status).must_equal 201
        _(last_response.header['Location'].size).must_be :>, 0
        schedule_data = JSON.parse last_response.body
        _(schedule_data.size).must_be :>, 0
      end

    end

    describe 'GETing database entities',:order => :defined do
      before do
        post "#{API_VER}/game_info/#{SEASON}/#{GAMEID}"
      end

      it 'HAPPY: should find stored game and player stats' do
        get "#{API_VER}/game_info/#{SEASON}/#{GAMEID}"
        _(last_response.status).must_equal 200
        game_data = JSON.parse last_response.body
        _(game_data.size).must_be :>, 0
      end

      it 'SAD: should report error if no database game entity found' do
        get "#{API_VER}/game_info/#{SEASON}/GGGameId"
        _(last_response.status).must_equal 404
      end
    end

  end
end
