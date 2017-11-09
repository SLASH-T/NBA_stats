#frozen_string_literal: true

require 'dry-monads'

module NBAStats
  # Service to find a repo from our database
  # Usage:
  #   result = FindDatabaseRepo.call(ownername: 'soumyaray', reponame: 'YPBT-app')
  #   result.success?
  module FindDatabasePlayer
    extend Dry::Monads::Either::Mixin
    def self.call(input)
      player = Repository::For[Entity::PlayerData].find_id(input[:game_id])
      if player
        Right(Result.new(:ok, player))
      else
        Left(Result.new(:not_found, 'Could not find stored Player'))
      end
    end
  end
end
