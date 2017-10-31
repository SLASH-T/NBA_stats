require_relative 'game_info_mapper.rb'
module NBAStats
  module MSFData
    # Accumulates scores data from the API Library MySportsFeeds
    class ScoreMapper
      def initialize(scores_data)
        @scores_data = scores_data
      end

      def seperate
        @scores_data.map do |data|
          ScoreMapper.build_entity(data)
        end
      end

      def self.build_entity(scores_data)
        DataMapper.new(scores_data).build_entity
      end


      # Maps Scores per quarter
      class DataMapper
        def initialize(scores_data)
          @scores = scores_data
          @away_quarter = { '1' => nil }
          @home_quarter = { '1' => nil }
        end

        def build_entity
          NBAStats::Entity::Scores.new(
            away_quarter: away_quarter,
            home_quarter: home_quarter
          )
        end

        private

        def away_score
          @away_quarter['0'] = @scores['quarterTotals']['awayScore']
        end

        def home_score
          @home_quarter['0'] = @scores['quarterTotals']['homeScore']
        end

        def away_quarter(quarter)
          @away_quarter['1'] = @scores[0]['awayScore']
          @away_quarter['2'] = @scores[1]['awayScore']
          @away_quarter['3'] = @scores[2]['awayScore']
          @away_quarter['4'] = @scores[3]['awayScore']
          @away_quarter[quarter.to_s]
        end

        def home_quarter(quarter)
          @home_quarter['1'] = @scores[0]['homeScore']
          @home_quarter['2'] = @scores[1]['homeScore']
          @home_quarter['3'] = @scores[2]['homeScore']
          @home_quarter['4'] = @scores[3]['homeScore']
          @home_quarter[quarter.to_s]
        end
      end
    end
  end
end
