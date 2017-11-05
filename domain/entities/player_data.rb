# frozen_string_literal: false

# require_relative 'init.rb'
require 'dry-struct'
# require_relative 'BoxScore.rb'

module NBAStats
  module Entity
    # Domain entity object for boxscore data
    class PlayerData < Dry::Struct
      attribute :id, Types::Int.optional
      attribute :origin_id, Types::Strict::String
      attribute :game_id, Types::Strict::String
      attribute :team_name, Types::Strict::String
      attribute :player_name, Types::Strict::String
      attribute :FGM, Types::Strict::String
      attribute :FGA, Types::Strict::String
      attribute :FGP, Types::Strict::String
      attribute :TPM, Types::Strict::String
      attribute :TPP, Types::Strict::String
      attribute :TPA, Types::Strict::String
      attribute :FTM, Types::Strict::String
      attribute :FTA, Types::Strict::String
      attribute :FTP, Types::Strict::String
      attribute :OREB, Types::Strict::String
      attribute :DREB, Types::Strict::String
      attribute :REB, Types::Strict::String
      attribute :AST, Types::Strict::String
      attribute :TOV, Types::Strict::String
      attribute :STL, Types::Strict::String
      attribute :BLK, Types::Strict::String
      attribute :PF, Types::Strict::String
      attribute :PTS, Types::Strict::String
      attribute :PM, Types::Strict::String
    end
  end
end
