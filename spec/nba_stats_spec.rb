# This is a testing script for the overal work

require_relative 'spec_helper.rb'

describe 'Tests if the MySportsFeeds API is correctly called' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<MySportsFeeds_AUTH>') { AUTH }
    c.filter_sensitive_data('<MySportsFeeds_AUTH_ESC>') { CGI.escape(AUTH) }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Tests if the Game Information is Correct' do
    it 'Checking Game Date' do
      @stats = MSFData::NBAStatsAPI.new(AUTH).msf_use(SEASON, DATE, TEAM)
      _(@stats.date).must_equal CORRECT['game']['date']
    end

    it 'Checking Game Location' do
      @stats = MSFData::NBAStatsAPI.new(AUTH).msf_use(SEASON, DATE, TEAM)
      _(@stats.location).must_equal CORRECT['game']['location']
    end

    it 'Check Away Team' do
      @stats = MSFData::NBAStatsAPI.new(AUTH).msf_use(SEASON, DATE, TEAM)
      _(@stats.away_team).must_equal CORRECT['game']['awayTeam']
    end

    it 'Check Home Team' do
      @stats = MSFData::NBAStatsAPI.new(AUTH).msf_use(SEASON, DATE, TEAM)
      _(@stats.home_team).must_equal CORRECT['game']['homeTeam']
    end
  end

  describe 'Tests if the Points are Correct' do
    it 'Check Total Scores from Away Team' do
      @stats = MSFData::NBAStatsAPI.new(AUTH).msf_use(SEASON, DATE, TEAM)
      _(@stats.scores.away_score).must_equal CORRECT['awayScore']
    end

    it 'Check Total Scores from Home Team' do
      @stats = MSFData::NBAStatsAPI.new(AUTH).msf_use(SEASON, DATE, TEAM)
      _(@stats.scores.home_score).must_equal CORRECT['homeScore']
    end

    it 'Check Away Team Scores Throughout 1st Quarter' do
      @stats = MSFData::NBAStatsAPI.new(AUTH).msf_use(SEASON, DATE, TEAM)
      path = CORRECT['Quaters']
      _(@stats.scores.away_quarter(1)).must_equal path['1']['awayScore']
      _(@stats.scores.away_quarter(2)).must_equal path['2']['awayScore']
      _(@stats.scores.away_quarter(3)).must_equal path['3']['awayScore']
      _(@stats.scores.away_quarter(4)).must_equal path['4']['awayScore']
    end

    it 'Check Home Team Scores Throughout 1st Quarter' do
      @stats = MSFData::NBAStatsAPI.new(AUTH).msf_use(SEASON, DATE, TEAM)
      path = CORRECT['Quaters']
      _(@stats.scores.home_quarter(1)).must_equal path['1']['homeScore']
      _(@stats.scores.home_quarter(2)).must_equal path['2']['homeScore']
      _(@stats.scores.home_quarter(3)).must_equal path['3']['homeScore']
      _(@stats.scores.home_quarter(4)).must_equal path['4']['homeScore']
    end
  end
end
