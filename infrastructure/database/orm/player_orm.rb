# frozen_string_literal: true

module NBAStats
  module Database
    # Object Relational Mapper for Repo Entities
    class PlayerOrm < Sequel::Model(:players)

      many_to_one :gameinfo,
                   class: :'NBAStats::Database::GameInfoOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end