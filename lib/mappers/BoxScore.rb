module MSFData
  require_relative '../lib/PlayerInfo.rb'
  # Accumulates data from the API Library MySportsFeeds
  class BoxScoreInfo
    def initialize(game_data)
      @game_data = game_data
      @away_team = @game_data['gameboxscore']['awayTeam']
      @home_team = @game_data['gameboxscore']['homeTeam']
    end

    def away_team_player
      @away_team['awayPlayers']['playerEntry'].map do |data|
        @playerinfo = Player.new(data)
      end
    end

    def home_team_player
      @home_team['homePlayers']['playerEntry'].map do |data|
        @playerinfo = Player.new(data)
      end
    end

  end
end