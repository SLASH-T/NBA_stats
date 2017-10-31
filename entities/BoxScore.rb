# frozen_string_literal: false

require_relative 'PlayerData.rb'

module NBAStats
  module Entity
    # Domain entity object for 2 teams
    class BoxScore < Dry::Struct
      attribute :away_team_player, Types::Strict::Array.member(PlayerData)
      attribute :home_team_player, Types::Strict::Array.member(PlayerData)
    end
  end
end
