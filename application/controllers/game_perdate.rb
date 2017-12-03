module NBAStats
  # Web API
  class Api < Roda
    plugin :json
    plugin :halt
    plugin :all_verbs

    route('game_info') do |routing|
      routing.on String, String do |season, game_id|
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
          puts service_result
          # puts service_result
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
    end

    route('player_info') do |routing|
      routing.on String, String do |season, game_id|
        # GET /api/v0.1/:season/:game_id request
        routing.get do
          find_result = FindDatabasePlayer.call(
            game_id: game_id
          )

          http_response = HttpResponseRepresenter.new(find_result.value)
          response.status = http_response.http_code
          if find_result.success?
            # puts "players"
            # puts find_result.value.message
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
          # puts service_result
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
    end
  end
end
