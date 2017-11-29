require_relative 'spec_helper.rb'

describe 'Tests if the MySportsFeeds API is correctly called' do
  extend Econfig::Shortcut
  Econfig.env = 'development'
  Econfig.root = '.'

  GH_TOKEN = config.MYSPORTS_AUTH

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Tests if the Ranking System is Correct' do
    it 'HAPPY: Checking Game Date' do
      player = NBAStats::MSFData::BoxScoreMapper.new(app.config)
      info = player.load_player(SEASON, GAMEID)
      puts info
    end
  end
end
