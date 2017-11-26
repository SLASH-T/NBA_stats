module NBAStats
  class ScheduleRepresenter < Roar::Decorator
    include Roar::JSON

    property :date
    property :location
    property :away_team
    property :home_team
    property :gameplayed_tag
    property :away_score
    property :home_score
  end
end
