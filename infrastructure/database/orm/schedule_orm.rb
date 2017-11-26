# frozen_string_literal: true

module NBAStats
  module Database
    # Object Relational Mapper for Repo Entities
    class ScheduleOrm < Sequel::Model(:schedules)

      one_to_many :gameinfos,
                   class: :'NBAStats::Database::GameInfoOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
