require_relative '../lib/msf_api.rb'
require 'yaml'
require_relative '../lib/mappers/game_info_mapper.rb'

SEASON = '2017-playoff'.freeze
GAMEID = '20170416-POR-GSW'.freeze
DATE = '20170416'.freeze
TEAM = 'GSW'.freeze
CONFIG = YAML.safe_load(File.read('../config/secrets.yml'))
AUTH = CONFIG['MYSPORTS_AUTH']
#CORRECT = YAML.safe_load(File.read('spec/fixtures/result.yml'))

api = MSFData::NBAStatsAPI.new(AUTH)
game_info_mapper = MSFData::GameInfoMapper.new(api)
game = game_info_mapper.load_several_game(SEASON,DATE,TEAM)
#puts game.date
#puts data.home_team_player.map(&:player_name)
#puts data.away_team_player.map(&:FGM)
