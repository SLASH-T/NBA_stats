module MSFData
  # Accumulates data from the API Library MySportsFeeds
  class Player
    def initialize(playerdata)
      @playerdata = playerdata
      @firstname = @playerdata['player']['FirstName']
      @lastname = @playerdata['player']['LastName']
      @stats = @playerdata['stats']
    end

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