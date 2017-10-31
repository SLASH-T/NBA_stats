require_relative 'spec_helper.rb'

describe 'Tests Api functionality' do
  API_VER = 'api/v0.1'.freeze
  CASSETTE_FILE = 'nba_stats_api'.freeze

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Game information' do
    it 'HAPPY: should provide correct game information' do
      get "#{API_VER}/game_info/#{SEASON}/#{GAMEID}"
      _(last_response.status).must_equal 200
      repo_data = JSON.parse last_response.body
      puts repo_data
      _(repo_data.size).must_be :>, 0
    end

=begin
    it 'SAD: should raise exception on incorrect game insertions' do
      get "#{API_VER}/game_info/error/#{GAMEID}"
      _(last_response.status).must_equal 404
    end
=end
  end

  describe 'Contributor information' do
  end
end
