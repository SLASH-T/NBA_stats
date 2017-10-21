# This is a testing script for the overal work

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/msf_api.rb'
require 'simplecov'
SimpleCov.start

describe 'Tests if the MySportsFeeds API is correctly called' do
  SEASON = '2017-playoff'.freeze
  DATE = '20170416'.freeze
  TEAM = 'GSW'.freeze
  CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
  AUTH = CONFIG['MYSPORTS_AUTH']
  CORRECT = YAML.safe_load(File.read('spec/fixtures/result.yml'))

  before do
    @stats = MSFData::NBAStatsAPI.new(AUTH).msf_use(SEASON, DATE, TEAM)
  end

  it 'Checking Game Date' do
    _(@stats.date).must_equal CORRECT['game']['date']
  end

  it 'Checking Game Location' do
    _(@stats.location).must_equal CORRECT['game']['location']
  end

  it 'Check Away Team' do
    _(@stats.away_team).must_equal CORRECT['game']['awayTeam']
  end
end
