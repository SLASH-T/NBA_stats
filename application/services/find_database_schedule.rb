# frozen_string_literal: true

require 'dry-monads'

module NBAStats
  # Service to find a repo from our database
  # Usage:
  module FindDatabaseSchedule
    extend Dry::Monads::Either::Mixin
    def self.call(input)
      schedule = Repository::For[Entity::Schedule].find_schedule(input[:date])
      if schedule
        Right(Result.new(:ok, schedule))
      else
        Left(Result.new(:not_found, 'Could not find stored Scheule'))
      end
    end
  end
end
