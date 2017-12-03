# frozen_string_literal: true

require 'roda'

module NBAStats
  # Web API
  class Api < Roda
    plugin :json
    plugin :halt
    plugin :all_verbs
    plugin :multi_route

    require_relative 'schedule'
    require_relative 'game_perdate'

    route do |routing|
      app = Api

      # GET/ request
      routing.root do
        { 'message' => "NBAStats API v0.1 up in #{app.environment} mode" }
      end

      routing.on 'api' do
        # /api/v0.1 branch
        routing.on 'v0.1' do
          routing.multi_route
        end
      end
    end
  end
end
