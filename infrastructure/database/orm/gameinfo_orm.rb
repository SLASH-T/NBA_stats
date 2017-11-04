# frozen_string_literal: true

module NBAStats
  module Database
    # Object Relational Mapper for Repo Entities
    class GameInfoOrm < Sequel::Model(:gameinfos)

      one_to_many :players,
                   class: :'NBAStats::Database::PlayerOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end