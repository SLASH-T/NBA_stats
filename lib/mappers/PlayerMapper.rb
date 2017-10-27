#require_relative '/Users/rogerxd/NBA_stats/NBA_stats/entities/PlayerData.rb'

module MSFData
  # Accumulates data from the API Library MySportsFeeds
  class PlayerMapper
    def initialize(playerdata)
      @playerdata = playerdata
      @firstname = @playerdata['player']['FirstName']
      @lastname = @playerdata['player']['LastName']
      @stats = @playerdata['stats']
    end

    def seperate
      @playerdata.map do |data|
        PlayerMapper.build_entity(data)
      end
    end

    def self.build_entity(player_data)
      DataMapper.new(player_data).build_entity
    end

    class DataMapper
      def initialize(player_data)
        @player_data = player_data
      end

      def build_entity
        Entity::PlayerData.new(
          player_name: player_name,
          FGM: FGM,
          FGA: FGA, 
          FGP: FGP, 
          TPM: TPM,
          TPP: TPP,
          TPA: TPA,
          FTM: FTM,
          FTA: FTA,
          FTP: FTP,
          OREB: OREB,
          DREB: DREB,
          REB: REB,
          AST: AST,
          TOV: TOV,
          STL: STL,
          BLK: BLK,
          PF: PF,
          PTS: PTS,
          PM:PM
        )
      end

      private


      def player_name
        @firstname + ' ' + @lastname
      end

      def FGM
        @stats['FgMade']['#text']
      end

      def FGA
        @stats['FgAtt']['#text']
      end

      def FGP
        @stats['FgPct']['#text']
      end

      def TPM 
        @stats['Fg3PtMade']['#text']
      end

      def TPA 
        @stats['Fg3PtAtt']['#text']
      end

      def TPP
        @stats['Fg3PtPct']['#text']
      end

      def FTM
        @stats['FtMade']['#text']
      end

      def FTA
        @stats['FtAtt']['#text']
      end

      def FTP
        @stats['FtPct']['#text']
      end

      def OREB
        @stats['OffReb']['#text']
      end

      def DREB
        @stats['DefReb']['#text']
      end

      def REB
        @stats['Reb']['#text']
      end

      def AST
        @stats['Ast']['#text']
      end

      def TOV
        @stats['Tov']['#text']
      end

      def STL
        @stats['Stl']['#text']
      end

      def BLK
        @stats['Blk']['#text']
      end

      def PF
        @stats['FoulPers']['#text']
      end

      def PTS
        @stats['Pts']['#text']
      end

      def PM
        @stats['PlusMinus']['#text']
      end
    end
  end
end