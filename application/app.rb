# frozen_string_literal: true

require 'roda'

module NBAStats
  # Web API
  class Api < Roda
    plugin :json
    plugin :halt

    route do |routing|
      app = Api

      # GET/ request
      routing.root do
        { 'message' => "NBAStats API v0.1 up in #{app.environment} mode" }
      end

      routing.on 'api' do
        # /api/v0.1 branch
        routing.on 'v0.1' do
          # /api/v0.1/:season/:game_id branch
          routing.on 'game_info', String, String do |season, game_id|
            # GET /api/v0.1/:season/:game_id request
            routing.get do
              find_result = FindDatabaseGameinfo.call(
                game_id: game_id
              )

              http_response = HttpResponseRepresenter.new(find_result.value)
              response.status = http_response.http_code
              if find_result.success?
                GameinfoRepresenter.new(find_result.value.message).to_json
              else
                http_response.to_json
              end
            end
            # POST '/api/v0.1/repo/:ownername/:reponame
            routing.post do
              service_result = LoadFromNBAstatsGame.new.call(
                config: app.config,
                season: season,
                game_id: game_id
              )
              #puts service_result
              http_response = HttpResponseRepresenter.new(service_result.value)
              response.status = http_response.http_code
              if service_result.success?
                response['Location'] = "/api/v0.1/game_info/#{season}/#{game_id}"
                GameinfoRepresenter.new(service_result.value.message).to_json
              else
                http_response.to_json
              end
            end
          end
          routing.on 'player_info', String, String do |season, game_id|
            # GET /api/v0.1/:season/:game_id request
            routing.get do
              find_result = FindDatabasePlayer.call(
                game_id: game_id
              )

              http_response = HttpResponseRepresenter.new(find_result.value)
              response.status = http_response.http_code
              if find_result.success?
                #puts "players"
                #puts find_result.value.message
                PlayersRepresenter.new(Players.new(find_result.value.message)).to_json
              else
                http_response.to_json
              end
            end
            # POST '/api/v0.1/repo/:ownername/:reponame
            routing.post do
              service_result = LoadFromNBAstatsPlayer.new.call(
                config: app.config,
                season: season,
                game_id: game_id
              )
              #puts service_result
              http_response = HttpResponseRepresenter.new(service_result.value)
              response.status = http_response.http_code
              if service_result.success?
                response['Location'] = "/api/v0.1/player/#{season}/#{game_id}"
                PlayersRepresenter.new(Players.new(service_result.value.message)).to_json
              else
                http_response.to_json
              end
            end
          end

          routing.on 'schedule', String, String do |season, date|
            # GET /api/v0.1/:season/:game_id request
            routing.get do
              find_result = FindDatabaseSchedule.call(
                date: date
              )
              #puts find_result
              http_response = HttpResponseRepresenter.new(find_result.value)
              response.status = http_response.http_code
              #puts find_result.value.message.class
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
              #puts service_result
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
  end
end
