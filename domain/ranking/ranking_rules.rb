module NBAStats
  module Ranking
    # Collects data from external API and ranks player perfromance
    class Rules
      def initialize(player_data, score)
        @data = player_data
        @score = score
      end

      def adjustment
        efg = (@data.FGM + 0.5 * @data.TPM) / @data.FGA

        if @data.TPA > 2
          case efg
          when 0.55..1
            @score += 15
          when 0.5..0.55
            @score += 10
          when 0.45..0.5
            @score += 5
          end
        end

        # Score rule : if a player scores alot, he gets extra credit
        case player_data.PTS
        when 80..150
          @score = 100
        when 60..80
          @score += 15
        when 50..60
          @score += 10
        when 40..50
          @score += 5
        end

        # Minus/Plus rule : if a player gets negative in minus/plus, points -
        @score -= 10 if player_data.PM < 0

        @score
      end
    end
  end
end
