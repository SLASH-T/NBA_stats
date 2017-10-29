#require_relative 'game_info_mapper.rb'
module MSFData
  # Accumulates data from the API Library MySportsFeeds
  class Scores
    def initialize(data)
      @data = data
    end

    def load_scores(date)
    #  scores_data = @gateway.msf_use(season, date, team)
      Scores.build_entity(data)
    end


    def self.build_entity(scores_data)
      DataMapper.new(scores_data).build_entity
    end

    class DataMapper
      def initialize(scores_data)
        @scores = scores_data
        @quarter = @scores['quarterSummary']['quarter']
        @away_quarter = { '1' => nil }
        @home_quarter = { '1' => nil }
      end

      def build_entity
          Entity::Scores.new(
            away_score: away_score,
            home_score: home_score,
            away_quarter: away_quarter,
            home_quarter: home_quarter,
          )
      end

      private

      def away_score
        @away_quarter['5'] = @scores['awayScore']
      end

      def home_score
        @home_quarter['5'] = @scores['homeScore']
      end

      def away_quarter(quarter)
        @away_quarter['1'] = @quarter[0]['awayScore']
        @away_quarter['2'] = @quarter[1]['awayScore']
        @away_quarter['3'] = @quarter[2]['awayScore']
        @away_quarter['4'] = @quarter[3]['awayScore']
        @away_quarter[quarter.to_s]
      end

      def home_quarter(quarter)
        @home_quarter['1'] = @quarter[0]['homeScore']
        @home_quarter['2'] = @quarter[1]['homeScore']
        @home_quarter['3'] = @quarter[2]['homeScore']
        @home_quarter['4'] = @quarter[3]['homeScore']
        @home_quarter[quarter.to_s]
      end
    end
  end
end
