module MSFData
  # Gives clear information about team scores
  class Scores
    def initialize(scores_data)
      @scores = scores_data
    end

    def away_score
      @away_score = @scores['awayScore']
    end

    def home_score
      @home_score = @scores['homeScore']
    end

    @quarter = @scores['quarterSummary']['quarter']

    def away_quarter
      @away_quarter = []
      @away_quarter[0] = @quarter[0]['awayScore']
      @away_quarter[1] = @quarter[1]['awayScore']
      @away_quarter[2] = @quarter[2]['awayScore']
      @away_quarter[3] = @quarter[3]['awayScore']
    end

    def home_quarter
      @home_quarter = []
      @home_quarter[0] = @quarter[0]['homeScore']
      @home_quarter[1] = @quarter[1]['homeScore']
      @home_quarter[2] = @quarter[2]['homeScore']
      @home_quarter[3] = @quarter[3]['homeScore']
    end
  end
end
