# frozen_string_literal: false
#require_relative 'game_info.rb'

module MSFData
  module Entity
    # Domain entity object for git contributors
    class Scores < Dry::Struct
      attribute :away_score, Types::Strict::String
      attribute :home_score, Types::Strict::String
      attribute :away_quarter, Types::Strict::String
      attribute :home_quarter, Types::Strict::String
    end
  end
end
