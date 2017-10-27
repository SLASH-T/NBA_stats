# frozen_string_literal: false
require 'dry-types'
require 'dry-struct'


module Types
  include Dry::Types.module
end

module MSFData
  module Entity
    # Domain entity object for git contributors
    class Scores < Dry::Struct
      attribute :away_score, Types::Strict::String
      attribute :home_score, Types::Strict::String
      attribute :away_quarter, Types::Strict::Array
      attribute :home_quarter, Types::Strict::Array
    end
  end
end
