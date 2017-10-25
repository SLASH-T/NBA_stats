require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'
require_relative '../lib/msf_api.rb'

SEASON = '2017-playoff'.freeze
GAMEID = '20170416-POR-GSW'.freeze
DATE = '20170416'.freeze
TEAM = 'GSW'.freeze
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
AUTH = CONFIG['MYSPORTS_AUTH']
CORRECT = YAML.safe_load(File.read('spec/fixtures/result.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'.freeze
CASSETTE_FILE = 'nba_stats_api'.freeze
