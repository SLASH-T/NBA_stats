module MSFData
  # Gives clear information about team scores
  class Scores
    def initialize(scores_data)
      @scores = scores_data
      @quarter = @scores['quarterSummary']['quarter']
    end

    def away_score
      @away_score = @scores['awayScore']
    end

    def home_score
      @home_score = @scores['homeScore']
    end

    def away_quarter(quarter)
      @away_quarter = { '1' => nil, '2' => nil, '3' => nil, '4' => nil }
      @away_quarter['1'] = @quarter[0]['awayScore']
      @away_quarter['2'] = @quarter[1]['awayScore']
      @away_quarter['3'] = @quarter[2]['awayScore']
      @away_quarter['4'] = @quarter[3]['awayScore']
      return @away_quarter[quarter.to_s]
    end

    def home_quarter(quarter)
      @home_quarter = { '1' => nil, '2' => nil, '3' => nil, '4' => nil }
      @home_quarter['1'] = @quarter[0]['homeScore']
      @home_quarter['2'] = @quarter[1]['homeScore']
      @home_quarter['3'] = @quarter[2]['homeScore']
      @home_quarter['4'] = @quarter[3]['homeScore']
      return @home_quarter[quarter.to_s]
    end
  end
end
