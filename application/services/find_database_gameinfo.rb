# frozen_string_literal: true

require 'dry-monads'

module NBAStats
  # Service to find game information from our database
  # Usage:
  module FindDatabaseGameinfo
    extend Dry::Monads::Either::Mixin
    def self.call(input)
      player = Repository::For[Entity::GameInfo].find_game(input[:game_id])
      if player
        Right(Result.new(:ok, player))
      else
        Left(Result.new(:not_found, 'Could not find stored GameInfo'))
      end
    end
  end
end
