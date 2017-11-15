# frozen_string_literal: true

require 'dry/transaction'

module NBAStats
  # Transaction to load repo from Github and save to database
  class LoadFromNBAstatsPlayer
    include Dry::Transaction

    step :get_player_from_nbastats
    step :check_if_player_already_loaded
    step :store_player_in_repository

    def get_player_from_nbastats(input)
      player = MSFData::BoxScoreMapper.new(input[:config])
                                      .load_player(input[:season], input[:game_id])
      Right(player: player)
    rescue StandardError
      Left(Result.new(:bad_request, 'Player not found'))
    end

    def check_if_player_already_loaded(input)
      if Repository::For[input[:player].class].find(input[:player])
        Left(Result.new(:conflict, 'Player already loaded'))
      else
        Right(input)
      end
    end

    def store_player_in_repository(input)
      stored_player = Repository::For[input[:player].class].create_form(input[:player])
      Right(Result.new(:created, stored_player))
    rescue StandardError => e
      puts e.to_s
      Left(Result.new(:internal_error, 'Could not store player'))
    end
  end
end
