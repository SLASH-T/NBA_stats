# frozen_string_literal: true

require 'roda'
require 'econfig'
require_relative 'lib/init.rb'
module MSFData
  # Web API
  class Api < Roda
    plugin :environments
    plugin :json
    plugin :halt

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

    route do |routing|
      app = Api
      config = Api.config
      # GET/ request
      routing.root do
        { 'message' => "MSFData API v0.1 up in #{app.environment}" }
      end

      routing.on 'api' do
        # /api/v0.1 branch
        routing.on 'v0.1' do
          routing.on 'game_info', String, String, String do |season, date, team|
            msf_api = NBAStatsAPI.new(config.MYSPORTS_AUTH)
            game_info_mapper = GameInfoMapper.new(msf_api)
            begin
              game_info = game_info_mapper.load_several_game(season, date, team)
            rescue StandardError
              routing.halt(404, error: 'Game info not found')
            end

            # GET /api/v0.1/
            routing.is do
              { game_info: { date: game_info.date, location: game_info.location\
                , away_team: game_info.away_team\
                , home_team: game_info.home_team } }
            end
          end
        end
      end
    end
  end
end
