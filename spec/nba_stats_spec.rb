# This is a testing script for the overal work

require_relative 'spec_helper.rb'
require 'econfig'

describe 'Tests if the MySportsFeeds API is correctly called' do
  extend Econfig::Shortcut
  Econfig.env = 'development'
  Econfig.root = '.'

  GH_TOKEN = config.MYSPORTS_AUTH
  CORRECT = YAML.safe_load(File.read('spec/fixtures/result.yml'))
  CASSETTE_FILE = 'nba_stats_api'.freeze

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Tests if the Game Information is Correct' do
    it 'HAPPY: Checking Game Date' do
      # api = NBAStats::MSFData::NBAStatsAPI.new(GH_TOKEN)
      game_info_mapper = NBAStats::MSFData::GameInfoMapper.new(app.config)
      game_info = game_info_mapper.load_data(SEASON, GAMEID)
      _(game_info.date).must_equal CORRECT['game']['date']
    end

    it 'SAD: Checking Game Date' do
      proc do
        api = MSFData::NBAStatsAPI.new(GH_TOKEN)
        game_info_mapper = MSFData::GameInfoMapper.new(api)
        game_info_mapper.load_several_game('ggggg', '11111111', 'ffffff')
      end.must_raise MSFData::NBAStatsAPI::Errors::NotFound
    end

    it 'Checking Game Location' do
      # api = NBAStats::MSFData::NBAStatsAPI.new(GH_TOKEN)
      game_info_mapper = NBAStats::MSFData::GameInfoMapper.new(app.config)
      game_info = game_info_mapper.load_data(SEASON, GAMEID)
      _(game_info.location).must_equal CORRECT['game']['location']
    end

    it 'Check Away Team' do
      # api = NBAStats::MSFData::NBAStatsAPI.new(GH_TOKEN)
      game_info_mapper = NBAStats::MSFData::GameInfoMapper.new(app.config)
      game_info = game_info_mapper.load_data(SEASON, GAMEID)
      _(game_info.away_team).must_equal CORRECT['game']['awayTeam']
    end

    it 'Check Home Team' do
      # api = NBAStats::MSFData::NBAStatsAPI.new(GH_TOKEN)
      game_info_mapper = NBAStats::MSFData::GameInfoMapper.new(app.config)
      game_info = game_info_mapper.load_data(SEASON, GAMEID)
      _(game_info.home_team).must_equal CORRECT['game']['homeTeam']
    end
  end
end
