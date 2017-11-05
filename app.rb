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
        { 'message' => "NBAStats API v0.1 up in #{app.environment}" }
      end

      routing.on 'api' do
        # /api/v0.1 branch
        routing.on 'v0.1' do
          # /api/v0.1/:season/:game_id branch
          routing.on 'game_info', String, String do |season, game_id|
            # GET /api/v0.1/:season/:game_id request
            routing.get do
              # game = Repository::For[Entity::GameInfo]
              # puts app.config + "------"

              game = Repository::GameInfos.find_game(game_id)

              routing.halt(404, error: 'Repository not found') unless game
              game.to_h
            end
            # POST '/api/v0.1/repo/:ownername/:reponame
            routing.post do
              begin
                #puts "GGGG"
                game = MSFData::GameInfoMapper.new(app.config)
                                              .load_data(season, game_id)
              rescue StandardError
                routing.halt(404, error: 'Repo not found')
              end

              # stored_game = Repository::For[game.class].find_or_create(game)
              stored_game = Repository::GameInfos.create_form(game)
              response.status = 201
              response['Location'] = "/api/v0.1/repo/#{season}/#{game_id}"
              stored_game.to_h
            end
          end
        end
      end
    end
  end
end
