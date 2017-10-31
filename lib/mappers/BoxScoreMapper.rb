#require_relative '/Users/rogerxd/NBA_stats/NBA_stats/lib/mappers/PlayerMapper.rb'
#require_relative '/Users/rogerxd/NBA_stats/NBA_stats/entities/BoxScore.rb'
require_relative 'PlayerMapper.rb'

module NBAStats
  module MSFData
    # Accumulates data from the API Library MySportsFeeds
    class BoxScoreMapper
      def initialize(gateway)
        @gateway = gateway
      end

      def load_player(season, gameid)
        boxscore = @gateway.msf_player_use(season, gameid)
        BoxScoreMapper.build_entity(boxscore)
      end

      def self.build_entity(boxscore)
        DataMapper.new(boxscore).build_entity
      end

      class DataMapper
        def initialize(boxscore)
          @boxscore = boxscore
          @away_team = @boxscore['gameboxscore']['awayTeam']
          @home_team = @boxscore['gameboxscore']['homeTeam']
        end

        def build_entity
<<<<<<< HEAD
          MSFData::Entity::BoxScore.new(
=======
          NBAStats::Entity::BoxScore.new(
>>>>>>> 3d6f63ea6f4a6409a3059f28f607c395dc608257
            away_team_player: away_team_player,
            home_team_player: home_team_player
          )
        end

        def away_team_player
<<<<<<< HEAD
          PlayerMapper.new(@away_team['awayPlayers']['playerEntry']).seperate
=======
          MSFData::PlayerMapper.new(@away_team['awayPlayers']['playerEntry']).seperate
>>>>>>> 3d6f63ea6f4a6409a3059f28f607c395dc608257
          #@away_team['awayPlayers']['playerEntry'].map do |data|
            #@playerinfo = PlayerMapper.new(data)
          #end
        end

        def home_team_player
<<<<<<< HEAD
          PlayerMapper.new(@home_team['homePlayers']['playerEntry']).seperate
=======
          MSFData::PlayerMapper.new(@home_team['homePlayers']['playerEntry']).seperate
>>>>>>> 3d6f63ea6f4a6409a3059f28f607c395dc608257
          #@home_team['homePlayers']['playerEntry'].map do |data|
           # @playerinfo = PlayerMapper.new(data)
          #end
        end
      end
    end
  end
end
