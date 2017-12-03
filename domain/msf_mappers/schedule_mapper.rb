module NBAStats
  module MSFData
    # Collects game data from the API Library MySportsFeeds
    class ScheduleMapper
      def initialize(config, gateway_class = MSFData::NBAStatsAPI)
        @config = config
        @gateway_class = gateway_class
        @gateway = gateway_class.new(@config.MYSPORTS_AUTH)
      end

      def load_data(season, date)
        @date = date
        @data = @gateway.msf_schedule(season, @date)
        @schedule = @data['scoreboard']['gameScore']
        # All game data are stored inside an array
        @schedule.map do |game_data|
          ScheduleMapper.build_entity(game_data, @date)
        end
      end

      def self.build_entity(game_data, date)
        DataMapper.new(game_data, date).build_entity
      end

      # Maps Game information data into initial varibles
      class DataMapper
        attr_reader :date

        def initialize(game_data, date)
          @date = date
          @game_data = game_data
        end

        def build_entity
          NBAStats::Entity::Schedule.new(
            id: nil,
            date: date,
            location: location,
            away_team: away_team,
            home_team: home_team,
            away_abbreviation: away_abbreviation,
            home_abbreviation: home_abbreviation,
            gameplayed_tag: gameplayed_tag,
            away_score: away_score,
            home_score: home_score
          )
        end

        private

        def location
          @game_data['game']['location']
        end

        def away_team
          @game_data['game']['awayTeam']['City']\
          + @game_data['game']['awayTeam']['Name']
        end

        def home_team
          @game_data['game']['homeTeam']['City']\
          + @game_data['game']['homeTeam']['Name']
        end

        def away_abbreviation
          @game_data['game']['awayTeam']['Abbreviation']
        end

        def home_abbreviation
          @game_data['game']['homeTeam']['Abbreviation']
        end

        def gameplayed_tag
          @game_data['isCompleted']
        end

        def away_score
          return nil unless @game_data['isCompleted'] == 'true'
          @game_data['awayScore']
        end

        def home_score
          return nil unless @game_data['isCompleted'] == 'true'
          @game_data['homeScore']
        end
      end
    end
  end
end
