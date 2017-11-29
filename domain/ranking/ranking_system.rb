module NBAStats
  module Ranking
    # Collects data from external API and ranks player perfromance
    class RankingSystem
      def initialize(player_data)
        @player = player_data
      end

      def ranking
        player_rank(@player)
      end

      private

      def player_rank(player_data)
        score = (player_data.PTS + 0.7 * player_data.OREB + 0.3\
        * player_data.DREB + 0.7 * player_data.AST + player_data.STL + 0.7\
        * player_data.BLK) + 0.4 * player_data.FGM - 0.7 * player_data.FGA\
        - 0.4 * (player_data.FTA - player_data.FTM)

        RankingRules.new(player_data, score).adjustment
      end
    end
  end
end
