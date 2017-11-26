require_relative 'schedule_representer'

module NBAStats
  class SchedulesRepresenter < Roar::Decorator
    include Roar::JSON

    collection :schedules, extend: ScheduleRepresenter
  end
end
