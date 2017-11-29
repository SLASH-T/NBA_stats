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
        score = (player_data.PTS.to_f + 0.7 * player_data.OREB.to_f + 0.3\
        * player_data.DREB.to_f + 0.7 * player_data.AST.to_f\
        + player_data.STL.to_f + 0.7 * player_data.BLK.to_f) + 0.4 * \
        player_data.FGM.to_f - 0.7 * player_data.FGA.to_f\
        - 0.4 * (player_data.FTA.to_f - player_data.FTM.to_f)

        Rules.new(player_data, score).adjustment
      end
    end
  end
end
