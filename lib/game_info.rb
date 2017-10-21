module MSFData
  # Accumulates data from the API Library MySportsFeeds
  class GameInfo
    def initialize(game_data)
      @game_data = game_data
      @game = @game_data['scoreboard']['gameScore'][0]['game']
    end

    def date
      @game['date']
    end

    def location
      @game['location']
    end

    def away_team
      @game['awayTeam']['City'] + ' ' + @game['awayTeam']['Name']
    end

    def home_team
      @game['homeTeam']['City'] + ' ' + @game['homeTeam']['Name']
    end

    def scores
      @scores ||= Scores.new(@game_data['scoreboard']['gameScore'][0])
    end
  end
end
