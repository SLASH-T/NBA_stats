# frozen_string_literal: false

# require_relative 'init.rb'
require 'dry-struct'
# require_relative 'BoxScore.rb'

module NBAStats
  module Entity
    # Domain entity object for boxscore data
    class PlayerData < Dry::Struct
      attribute :id, Types::Int.optional
      attribute :origin_id, Types::Strict::String.optional
      attribute :gameinfo_id, Types::Strict::String.optional
      attribute :game_id, Types::Strict::String.optional
      attribute :team_name, Types::Strict::String.optional
      attribute :player_name, Types::Strict::String.optional
      attribute :FGM, Types::Strict::String.optional
      attribute :FGA, Types::Strict::String.optional
      attribute :FGP, Types::Strict::String.optional
      attribute :TPM, Types::Strict::String.optional
      attribute :TPP, Types::Strict::String.optional
      attribute :TPA, Types::Strict::String.optional
      attribute :FTM, Types::Strict::String.optional
      attribute :FTA, Types::Strict::String.optional
      attribute :FTP, Types::Strict::String.optional
      attribute :OREB, Types::Strict::String.optional
      attribute :DREB, Types::Strict::String.optional
      attribute :REB, Types::Strict::String.optional
      attribute :AST, Types::Strict::String.optional
      attribute :TOV, Types::Strict::String.optional
      attribute :STL, Types::Strict::String.optional
      attribute :BLK, Types::Strict::String.optional
      attribute :PF, Types::Strict::String.optional
      attribute :PTS, Types::Strict::String.optional
      attribute :PM, Types::Strict::String.optional
    end
  end
end
