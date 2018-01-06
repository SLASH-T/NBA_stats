module NBAStats
  module MSFData
    # Accumulates data from the API Library MySportsFeeds
    class BoxScoreMapper
      def initialize(config, gateway_class = MSFData::NBAStatsAPI)
        @config = config
        @gateway_class = gateway_class
        @gateway = gateway_class.new(@config.MYSPORTS_AUTH)
      end

      def load_player(season, gameid)
        @gameid = gameid
        @boxscore = @gateway.msf_player_use(season, gameid)
        # combine team_name
        @team_name = @boxscore['gameboxscore']['game']
        @away_team_name = @team_name['awayTeam']['City'] + ' ' + @team_name['awayTeam']['Name']
        @home_team_name = @team_name['homeTeam']['City'] + ' ' + @team_name['homeTeam']['Name']
        # player_data seperate awayTeam homeTeam
        @away_team = @boxscore['gameboxscore']['awayTeam']
        @home_team = @boxscore['gameboxscore']['homeTeam']
        @player_away_data = @away_team['awayPlayers']['playerEntry']
        @player_home_data = @home_team['homePlayers']['playerEntry']

        # put home_team_name into player hash
        @player_home_data.map do |home_data|
          home_data['player']['team_name'] = @home_team_name
        end
        # put away_team_name into player hash
        @player_away_data.map do |away_data|
          away_data['player']['team_name'] = @away_team_name
        end

        @player_datas = @player_home_data + @player_away_data

        # return Entities
        @player_datas.map do |player_data|
          BoxScoreMapper.build_entity(player_data, player_data['player']['team_name'], @gameid)
        end
      end

      def self.build_entity(player_data, team_name, gameid)
        DataMapper.new(player_data, team_name, gameid).build_entity
      end

      # Maps date to db
      class DataMapper
        def initialize(player_data, team_name, gameid)
          @player_data = player_data
          @team_name = team_name
          @gameid = gameid
        end

        def build_entity
          NBAStats::Entity::PlayerData.new(
            id: nil, # primary key
            origin_id: origin_id,
            gameinfo_id: nil, # foreign key
            game_id: game_id,
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
            PM: pm,
            RK: rk
          )
        end

        private

        def game_id
          @gameid
        end

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

        def rk
          0.0
        end
      end
    end
  end
end
