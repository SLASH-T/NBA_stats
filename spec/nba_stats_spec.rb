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
end
