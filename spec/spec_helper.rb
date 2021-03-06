
ENV['RACK_ENV'] = 'development'

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative 'test_load_all'

load 'Rakefile'
Rake::Task['db:reset'].invoke

SEASON = '2017-playoff'.freeze
GAMEID = '20170416-POR-GSW'.freeze
DATE = '20170416'.freeze
# CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
# AUTH = CONFIG['MYSPORTS_AUTH']
CORRECT = YAML.safe_load(File.read('spec/fixtures/result.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'.freeze
CASSETTE_FILE = 'nba_stats_api'.freeze
# puts app.environment

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock

  token = app.config.MYSPORTS_AUTH
  c.filter_sensitive_data('<MySportsFeeds_AUTH>') { token }
  c.filter_sensitive_data('<MySportsFeeds_AUTH_ESC>') { CGI.escape(token) }
end
