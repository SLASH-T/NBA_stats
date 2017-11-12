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
                PlayerRepresenter.new(find_result.value.message).to_json
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

              http_response = HttpResponseRepresenter.new(service_result.value)
              response.status = http_response.http_code
              if service_result.success?
                response['Location'] = "/api/v0.1/player/#{season}/#{game_id}"
                PlayerRepresenter.new(service_result.value.message).to_json
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
