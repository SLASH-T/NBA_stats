# frozen_string_literal: true

require 'dry/transaction'

module NBAStats
  # Transaction to load repo from Github and save to database
  class LoadFromNBAstatsGame
    include Dry::Transaction

    step :get_gameinfo_from_nbastats
    step :check_if_gameinfo_already_loaded
    step :store_gameinfo_in_repository

    def get_gameinfo_from_nbastats(input)
      game_info = MSFData::GameInfoMapper.new(input[:config])
                                         .load_data(input[:season], input[:game_id])

      # puts game_info
      Right(game_info: game_info)
    rescue StandardError
      Left(Result.new(:bad_request, 'MSF gameinfo data not found'))
    end

    def check_if_gameinfo_already_loaded(input)
      if Repository::For[input[:game_info].class].find(input[:game_info])
        Left(Result.new(:conflict, 'Gameinfo already loaded'))
      else
        Right(input)
      end
    end

    def store_gameinfo_in_repository(input)
      stored_gameinfo = Repository::For[input[:game_info].class].create_form(input[:game_info])
      Right(Result.new(:created, stored_gameinfo))
    rescue StandardError => e
      puts e.to_s
      Left(Result.new(:internal_error, 'Could not store gameinfo'))
    end
  end
end
