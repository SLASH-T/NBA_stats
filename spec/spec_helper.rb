<<<<<<< HEAD
=======

>>>>>>> 3d6f63ea6f4a6409a3059f28f607c395dc608257
ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'
require 'yaml'
require 'vcr'
require 'webmock'
<<<<<<< HEAD
# require_relative '../lib/msf_api.rb'
=======
#require_relative '../lib/msf_api.rb'
>>>>>>> 3d6f63ea6f4a6409a3059f28f607c395dc608257
require_relative 'test_load_all'

SEASON = '2017-playoff'.freeze
GAMEID = '20170416-POR-GSW'.freeze
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
#AUTH = CONFIG['MYSPORTS_AUTH']
CORRECT = YAML.safe_load(File.read('spec/fixtures/result.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'.freeze
CASSETTE_FILE = 'nba_stats_api'.freeze

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock

  token = app.config.MYSPORTS_AUTH
  c.filter_sensitive_data('<MySportsFeeds_AUTH>') { token }
  c.filter_sensitive_data('<MySportsFeeds_AUTH_ESC>') { CGI.escape(token) }
end
