# frozen_string_literal: true

require 'dry/transaction'

module NBAStats
  # Transaction to summarize folder from local repo
  class ScheduleQueue
    include Dry::Transaction

    step :schedule_exist

    def schedule_exist(input)
      puts "666666"
      if !input[:find_result].empty?
        puts "777777"
        Right(input[:find_result])
      else
        puts "8888888"
        loadmsg = []
        loadmsg.push(input[:config])
        loadmsg.push(input[:season])
        loadmsg.push(input[:date])
        CloneWorker.perform_async(loadmsg)
        Left(Result.new(:processing, 'Processing the summary request'))
      end
    end
  end
end