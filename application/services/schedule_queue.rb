# frozen_string_literal: true

require 'dry/transaction'

module NBAStats
  # Transaction to summarize folder from local repo
  class ScheduleQueue
    include Dry::Transaction

    step :schedule_exist

    def schedule_exist(input)
      if !input[:find_result].empty?
        Right(input[:find_result])
      else
        loadmsg = input[:season] + "!" + input[:date]
        puts loadmsg
        CloneWorker.perform_async(loadmsg)
        Left(Result.new(:processing, 'Processing the summary request'))
      end
    end
  end
end