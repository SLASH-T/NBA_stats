# frozen_string_literal: false

require 'dry-struct'

module NBAStats
  module Entity
    # Domain entity object for git contributors
    class Schedule < Dry::Struct
      attribute :id, Types::Int.optional
      attribute :date, Types::Strict::String.optional
      attribute :location, Types::Strict::String.optional
      attribute :away_team, Types::Strict::String.optional
      attribute :home_team, Types::Strict::String.optional
      attribute :away_abbreviation, Types::Strict::String.optional
      attribute :home_abbreviation, Types::Strict::String.optional
      attribute :gameplayed_tag, Types::Strict::String.optional
      attribute :away_score, Types::Strict::String.optional
      attribute :home_score, Types::Strict::String.optional
    end
  end
end
