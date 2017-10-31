# require '../entities/game_info.rb'
require_relative 'scores_mapper.rb'

module NBAStats
  module MSFData
    # Collects game data from the API Library MySportsFeeds
    class GameInfoMapper
      def initialize(gateway)
        @gateway = gateway
      end

      def load_game(season, gameid)
        game_data = @gateway.msf_player_use(season, gameid)
        GameInfoMapper.build_entity(game_data)
      end

      def self.build_entity(game_data)
        DataMapper.new(game_data).build_entity
      end

      # Maps Game information data into initial varibles
      class DataMapper
        def initialize(game_data)
          @game_data = game_data
          # set base
          @game_team = @game_data['gameboxscore']['game']
          @game_score = @game_data['gameboxscore']
          # set base
          @game_away = @game_team['awayTeam']
          @game_home = @game_team['homeTeam']
          @scores = @game_score['quarterSummary']['quarter']
        end

        def build_entity
          NBAStats::Entity::GameInfo.new(
            date: date,
            location: location,
            away_team: away_team,
            home_team: home_team,
            scores: scores
          )
        end

        private

        def date
          @game_team['date']
        end

        def location
          @game_team['location']
        end

        def away_team
          @game_away['City'] + ' ' + @game_away['Name']
        end

        def home_team
          @game_home['City'] + ' ' + @game_home['Name']
        end

        def scores
          @score ||= 'Scores.load(gateway)'
        end
      end
    end
  end
end
