# frozen_string_literal: false

# require 'game_info.rb'
module NBAStats
  module Entity
    # Domain entity object for git contributors
    class Scores < Dry::Struct
      attribute :away_quarter, Types::Strict::String
      attribute :home_quarter, Types::Strict::String
    end
  end
end
