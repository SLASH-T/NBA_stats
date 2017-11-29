# frozen_string_literal: true

require 'dry/transaction'

module NBAStats
  # Transaction to load repo from Github and save to database
  class LoadFromSchedule
    include Dry::Transaction

    step :get_schedule_from_nbastats
    step :check_if_schedule_already_loaded
    step :store_schedule_in_repository

    def get_schedule_from_nbastats(input)
      schedule = MSFData::ScheduleMapper.new(input[:config])
                                      .load_data(input[:season], input[:date])
      Right(schedule: schedule)
    rescue StandardError
      Left(Result.new(:bad_request, 'Schedule not found'))
    end

    def check_if_schedule_already_loaded(input)
      if Repository::Schedules.find_one(input[:schedule])
        #puts "---------"
        #puts Repository::Schedules.find_one(input[:schedule])
        Left(Result.new(:conflict, 'Schedule already loaded'))
      else
        #puts "Right----------"
        Right(input)
      end
    end

    def store_schedule_in_repository(input)
      stored_schedule = Repository::Schedules.create_form(input[:schedule])
      Right(Result.new(:created, stored_schedule))
    rescue StandardError => e
      puts e.to_s
      Left(Result.new(:internal_error, 'Could not store schedule'))
    end
  end
end
