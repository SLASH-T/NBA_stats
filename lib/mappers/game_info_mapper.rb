# require '../entities/game_info.rb'
# require_relative 'scores_mapper.rb'

module NBAStats
  module MSFData
    # Collects game data from the API Library MySportsFeeds
    class GameInfoMapper
      def initialize(gateway)
        @gateway = gateway
      end

      def load_data(season, gameid)
        game_data = @gateway.msf_player_use(season, gameid)
        GameInfoMapper.build_entity(game_data)
      end

      def self.build_entity(game_data)
        DataMapper.new(game_data).build_entity
      end

      # Maps Game information data into initial varibles
      class DataMapper
        def initialize(game_data)
          @game_data = game_data
          @game_data_mod = @game_data['gameboxscore']['game']
          @game_away = @game_data_mod['awayTeam']
          @game_home = @game_data_mod['homeTeam']
          @scores = { 'awayTeam' => { 'total' => nil },
                      'homeTeam' => { 'total' => nil } }
        end

        def build_entity
          NBAStats::Entity::GameInfo.new(
            date: date,
            location: location,
            away_team: away_team,
            home_team: home_team,
            away_score: away_score,
            home_score: home_score,
            away_score_q1: away_score_q1,
            away_score_q2: away_score_q2,
            away_score_q3: away_score_q3,
            away_score_q4: away_score_q4,
            home_score_q1: home_score_q1,
            home_score_q2: home_score_q2,
            home_score_q3: home_score_q3,
            home_score_q4: home_score_q4
          )
        end

        private

        def date
          @game_data_mod['date']
        end

        def location
          @game_data_mod['location']
        end

        def away_team
          @game_away['City'] + ' ' + @game_away['Name']
        end

        def home_team
          @game_home['City'] + ' ' + @game_home['Name']
        end

        def away_score
          @scores['awayTeam']['total'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarterTotals']['awayScore']
        end

        def home_score
          @scores['homeTeam']['total'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarterTotals']['homeScore']
        end

        def away_score_q1
          @scores['awayTeam']['1'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarter'][0]['awayScore']
        end

        def away_score_q2
          @scores['awayTeam']['2'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarter'][1]['awayScore']
        end

        def away_score_q3
          @scores['awayTeam']['3'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarter'][2]['awayScore']
        end

        def away_score_q4
          @scores['awayTeam']['4'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarter'][3]['awayScore']
        end

        def home_score_q1
          @scores['homeTeam']['1'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarter'][0]['homeScore']
        end

        def home_score_q2
          @scores['homeTeam']['2'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarter'][1]['homeScore']
        end

        def home_score_q3
          @scores['homeTeam']['3'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarter'][2]['homeScore']
        end

        def home_score_q4
          @scores['homeTeam']['4'] = @game_data['gameboxscore']\
          ['quarterSummary']['quarter'][3]['homeScore']
        end
      end
    end
  end
end
