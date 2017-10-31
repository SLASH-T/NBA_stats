require_relative '../lib/msf_api.rb'
require 'yaml'

SEASON = '2017-playoff'.freeze
GAMEID = '20170416-POR-GSW'.freeze
DATE = '20170416'.freeze
TEAM = 'GSW'.freeze
CONFIG = YAML.safe_load(File.read('../config/secrets.yml'))
AUTH = CONFIG['MYSPORTS_AUTH']
#CORRECT = YAML.safe_load(File.read('spec/fixtures/result.yml'))

data = MSFData::NBAStatsAPI.new(AUTH).msf_player_use(SEASON, GAMEID)
puts data.home_team_player.map(&:player_name)
#puts data.away_team_player.map(&:FGM)
