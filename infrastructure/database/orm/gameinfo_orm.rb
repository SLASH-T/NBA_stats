# frozen_string_literal: true

module NBAStats
  module Database
    # Object Relational Mapper for Repo Entities
    class GameInfoOrm < Sequel::Model(:gameinfos)

      one_to_many :players,
                   class: :'NBAStats::Database::PlayerOrm'
      many_to_one :schedules,
                   class: :'NBAStats::Database::ScheduleOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
