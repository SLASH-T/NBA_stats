#require '../entities/game_info.rb'
#require_relative 'scores_mapper.rb'
module MSFData
  # Accumulates data from the API Library MySportsFeeds
  class GameInfoMapper
    def initialize(gateway)
      @gateway = gateway
    end

    def load_several_game(season, date, team)
      game_data = @gateway.msf_use(season, date, team)# game_data is a json data type
      GameInfoMapper.build_entity(game_data)
    end

    def self.build_entity(game_data)
      DataMapper.new(game_data).build_entity
    end

    class DataMapper
      def initialize(game_data)
        @game_data = game_data
        @game = @game_data['scoreboard']['gameScore'][0]['game']
        @game_away ||= @game['awayTeam']
        @game_home ||= @game['homeTeam']
      end

      def build_entity
        MSFData::Entity::GameInfo.new(
          date: date,
          location: location,
          away_team: away_team,
          home_team: home_team,
          scores: scores
        )
      end

      private

      def date
        @game['date']
      end

      def location
        @game['location']
      end

      def away_team
        @away = @game_away['City'] + ' ' + @game_away['Name']
      end

      def home_team
        @home = @game_home['City'] + ' ' + @game_home['Name']
      end

      def scores
        @scores ||= "GGG"#Scores.load_scores(@game_data['scoreboard']['gameScore'][0])
      end
    end
  end
end
