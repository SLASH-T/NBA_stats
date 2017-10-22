module MSFData
  # Accumulates data from the API Library MySportsFeeds
  class GameInfo
    def initialize(game_data)
      @game_data = game_data
      @game = @game_data['scoreboard']['gameScore'][0]['game']
      @game_away ||= @game['awayTeam']
      @game_home ||= @game['homeTeam']
    end

    def date
      @game['date']
    end

    def location
      @game['location']
    end

    def away_team
      @away = @game_away['City'] + ' ' + @game_away['Name']
    end

    def home_team
      @home = @game_home['City'] + ' ' + @game_home['Name']
    end

    def scores
      @scores ||= Scores.new(@game_data['scoreboard']['gameScore'][0])
    end
  end
end
