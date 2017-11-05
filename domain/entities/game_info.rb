# frozen_string_literal: false

require 'dry-struct'

module NBAStats
  module Entity
    # Domain entity object for git contributors
    class GameInfo < Dry::Struct
      attribute :id, Types::Int.optional
      attribute :origin_id, Types::Strict::String
      attribute :date, Types::Strict::String
      attribute :location, Types::Strict::String
      attribute :away_team, Types::Strict::String
      attribute :home_team, Types::Strict::String
      attribute :away_score, Types::Strict::String
      attribute :home_score, Types::Strict::String
      attribute :away_score_q1, Types::Strict::String
      attribute :away_score_q2, Types::Strict::String
      attribute :away_score_q3, Types::Strict::String
      attribute :away_score_q4, Types::Strict::String
      attribute :home_score_q1, Types::Strict::String
      attribute :home_score_q2, Types::Strict::String
      attribute :home_score_q3, Types::Strict::String
      attribute :home_score_q4, Types::Strict::String
    end
  end
end
