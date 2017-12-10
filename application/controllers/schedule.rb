module NBAStats
  # Web API
  class Api < Roda
    plugin :json
    plugin :halt
    plugin :all_verbs

    route('schedule') do |routing|
      app = Api
      routing.on String, String do |season, date|
        # GET /api/v0.1/:season/:game_id request
        routing.get do
          find_result = FindDatabaseSchedule.call(
            date: date
          )
          puts find_result

          

          if find_result.value.message.empty?
            service_result = ScheduleQueue.new.call(
              find_result: find_result.value.message,
              config: app.config,
              season: season,
              date: date
            )
=begin
            service_result = LoadFromSchedule.new.call(
              config: app.config,
              season: season,
              date: date
            )
            puts service_result
=end
            puts "--------"
            puts service_result
            http_response = HttpResponseRepresenter.new(service_result.value)
            response.status = http_response.http_code
            if service_result.success?
              response['Location'] = "/api/v0.1/schedule/#{season}/#{date}"
              SchedulesRepresenter.new(Schedules.new(service_result.value.message)).to_json
              find_result.value.message = service_result.value.message
            else
              http_response.to_json
            end
          end

          http_response = HttpResponseRepresenter.new(find_result.value)
          response.status = http_response.http_code
          # puts find_result.value.message.class
          if find_result.success?
            SchedulesRepresenter.new(Schedules.new(find_result.value.message)).to_json
          else
            http_response.to_json
          end
        end
        # POST '/api/v0.1/repo/:ownername/:reponame
        routing.post do
          service_result = LoadFromSchedule.new.call(
            config: app.config,
            season: season,
            date: date
          )
          puts service_result
          http_response = HttpResponseRepresenter.new(service_result.value)
          response.status = http_response.http_code
          if service_result.success?
            response['Location'] = "/api/v0.1/schedule/#{season}/#{date}"
            SchedulesRepresenter.new(Schedules.new(service_result.value.message)).to_json
          else
            http_response.to_json
          end
        end
      end
    end
  end
end
