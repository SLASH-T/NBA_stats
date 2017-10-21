require 'http'
require_relative 'game_info.rb'
require_relative 'scores.rb'

module MSFData
  module Errors
    # Not allowed to access resource
    Unauthorized = Class.new(StandardError)
    # Requested resource not found
    NotFound = Class.new(StandardError)
  end

  # makes an API call
  class NBAStatsAPI
    # Encapsulates API response success and errors
    class Response
      HTTP_ERROR = {
        401 => Errors::Unauthorized,
        404 => Errors::NotFound
      }.freeze

      def initialize(response)
        @response = response
      end

      def successful?
        HTTP_ERROR.keys.include?(@response.code) ? false : true
      end

      def response_or_error
        successful? ? @response : raise(HTTP_ERROR[@response.code])
      end
    end

    def initialize(token)
      @msf_token = token
    end

    def msf_use(season, date, team)
      uri = uri_path(season, date, team)
      data = call_stats_uri(uri).parse
      GameInfo.new(data)
    end

    private

    def uri_path(season = '2017-playoff', date = '20170416', team = 'GSW')
      'https://api.mysportsfeeds.com/v1.1/pull/nba/' + season\
       + '/scoreboard.json?fordate=' + date\
       + '&team=' + team
    end

    def call_stats_uri(uri)
      response = HTTP.headers('Authorization' => @msf_token).get(uri)
      Response.new(response).response_or_error
    end
  end
end
