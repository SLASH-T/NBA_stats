module NBAStats
  module Ranking
    # Collects data from external API and ranks player perfromance
    class Rules
      def initialize(player_data, score)
        @data = player_data
        @score = score
      end

      def adjustment
        efg = (@data.FGM.to_f + 0.5 * @data.TPM.to_f) / @data.FGA.to_f

        if @data.TPA.to_f > 2
          case efg
          when 0.55..1
            @score += 3
          when 0.5..0.55
            @score += 2
          when 0.45..0.5
            @score += 1
          end
        end

        # Score rule : if a player scores alot, he gets extra credit
        case @data.PTS.to_f
        when 80..150
          @score = 100
        when 60..80
          @score += 5
        when 50..60
          @score += 3
        when 40..50
          @score += 2
        when 30..40
          @score += 1
        end

        # Minus/Plus rule : if a player gets negative in minus/plus, points -
        @score -= 5 if @data.PM.to_f < 0

        @score
      end
    end
  end
end
