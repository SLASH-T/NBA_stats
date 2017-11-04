#require_relative '/Users/rogerxd/NBA_stats/NBA_stats/lib/mappers/PlayerMapper.rb'
#require_relative '/Users/rogerxd/NBA_stats/NBA_stats/entities/BoxScore.rb'
#require_relative 'PlayerMapper.rb'

module NBAStats
  module MSFData
    # Accumulates data from the API Library MySportsFeeds
    class BoxScoreMapper
      def initialize(config, gateway_class = MSFDate::NBAStatsAPI)
        @config = config
        @gateway_class = gateway_class
        @gateway = gateway_class.new(@config.MYSPORTS_AUTH)
      end

      def load_player(season, gameid)
        boxscore = @gateway.msf_player_use(season, gameid)
        #BoxScoreMapper.build_entity(boxscore)
        @boxscore = boxscore
        @team_name = @boxscore['gameboxscore']['game']
        @away_team_name = @team_name['awayTeam']['City'] + ' ' + @team_name['awayTeam']['Name']
        @home_team_name = @team_name['homeTeam']['City'] + ' ' + @team_name['homeTeam']['Name']
        @away_team = @boxscore['gameboxscore']['awayTeam']
        @home_team = @boxscore['gameboxscore']['homeTeam']
        @player_away_data = @away_team['awayPlayers']['playerEntry']
        @player_home_data = @home_team['homePlayers']['playerEntry']
        @player_home_data.map do |home_data|
          BoxScoreMapper.build_entity(home_data, @home_team_name)
        end

        @player_away_data.map do |away_data|
          BoxScoreMapper.build_entity(away_data, @away_team_name)
        end
      end

      def self.build_entity(player_data, team_name)
        DataMapper.new(player_data, team_name).build_entity
      end

      class DataMapper
        def initialize(player_data, team_name)
          @player_data = player_data
          @team_name = team_name
        end

        def build_entity
          NBAStats::Entity::BoxScore.new(
            id: nil,
            origin_id: origin_id,
            team_name: team_name,
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


        def origin_id
          @player_data['player']['ID']
        end

        def player_name
          @player_data['player']['FirstName'] + ' ' + @player_data['player']['LastName']
        end

        def team_name
          @team_name
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
end
