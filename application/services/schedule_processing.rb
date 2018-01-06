# frozen_string_literal: true

require 'dry/transaction'

module NBAStats
  # Transaction to summarize folder from local repo
  class ScheduleProccessing
    include Dry::Transaction

    step :clone_or_find_schedule

    def clone_or_find_schedule(input)
      if !input[:result].empty?
        Right(input)
      else
        service_result = LoadFromSchedule.new.call(
          config: input[:config],
          season: input[:season],
          date: input[:date]
        )
        CloneWorker.perform_async(repo_json)
        Left(Result.new(:processing, 'Processing the summary request'))
      end
    rescue
      Left(Result.new(:internal_error, 'Could not clone repo'))
    end
  end
end
