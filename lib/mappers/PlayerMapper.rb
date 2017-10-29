#require_relative '/Users/rogerxd/NBA_stats/NBA_stats/entities/PlayerData.rb'

module MSFData
  # Accumulates data from the API Library MySportsFeeds
  class PlayerMapper
    def initialize(playerdata)# array
      @playerdata = playerdata
      #@firstname = @playerdata[0]['player']['FirstName']
      #@lastname = @playerdata[0]['player']['LastName']
      #@stats = @playerdata[0]['stats']
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
        MSFData::Entity::PlayerData.new(
          player_name: player_name,
          FGM: fgm,
          FGA: fga,
          FGP: fgp,
          TPM: tpm,
          TPP: tpp,
          TPA: tpa,
          FTM: ftm,
          FTA: fta,
          FTP: ftp,
          OREB: oreb,
          DREB: dreb,
          REB: reb,
          AST: ast,
          TOV: tov,
          STL: stl,
          BLK: blk,
          PF: pf,
          PTS: pts,
          PM: pm
        )
      end

      private


      def player_name
        @player_data['player']['FirstName'] + ' ' + @player_data['player']['LastName']
      end

      def fgm
      @player_data['stats']['FgMade']['#text']
      end

      def fga
        @player_data['stats']['FgAtt']['#text']
      end

      def fgp
        @player_data['stats']['FgPct']['#text']
      end

      def tpm
        @player_data['stats']['Fg3PtMade']['#text']
      end

      def tpa
        @player_data['stats']['Fg3PtAtt']['#text']
      end

      def tpp
        @player_data['stats']['Fg3PtPct']['#text']
      end

      def ftm
        @player_data['stats']['FtMade']['#text']
      end

      def fta
        @player_data['stats']['FtAtt']['#text']
      end

      def ftp
        @player_data['stats']['FtPct']['#text']
      end

      def oreb
        @player_data['stats']['OffReb']['#text']
      end

      def dreb
        @player_data['stats']['DefReb']['#text']
      end

      def reb
        @player_data['stats']['Reb']['#text']
      end

      def ast
        @player_data['stats']['Ast']['#text']
      end

      def tov
        @player_data['stats']['Tov']['#text']
      end

      def stl
        @player_data['stats']['Stl']['#text']
      end

      def blk
        @player_data['stats']['Blk']['#text']
      end

      def pf
        @player_data['stats']['FoulPers']['#text']
      end

      def pts
        @player_data['stats']['Pts']['#text']
      end

      def pm
        @player_data['stats']['PlusMinus']['#text']
      end
    end
  end
end
