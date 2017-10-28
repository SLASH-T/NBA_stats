# frozen_string_literal: false
require 'dry-struct'

module MSFData
  module Entity
    # Domain entity object for git contributors
    class GameInfo < Dry::Struct
      attribute :date, Types::Strict::String
      attribute :location, Types::Strict::String
      attribute :away_team, Types::Strict::String
      attribute :home_team, Types::Strict::String
      attribute :scores, Types::Strict::String
    end
  end
end
