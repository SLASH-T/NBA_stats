require 'http'
# require_relative 'mappers/game_info_mapper.rb'
# require_relative 'mappers/scores_mapper.rb'
# require_relative 'mappers/BoxScore.rb'

TEST_SEASON = '2017-playoff'.freeze
# TEST_SEASON2 = '2017-2018-regular'.freeze
TEST_GAMEID = '20170416-POR-GSW'.freeze

module NBAStats
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

      def msf_player_use(season, gameid)
        uri = NBAStatsAPI.player_uri_path(season, gameid)
        call_stats_uri(uri).parse
      end

      def msf_schedule(season, date)
        uri = NBAStatsAPI.schedule_uri_path(season, date)
        call_stats_uri(uri).parse
      end

      def self.schedule_uri_path(season, date)
        'https://api.mysportsfeeds.com/v1.1/pull/nba/' + season\
        + '/scoreboard.json?fordate=' + date
      end

      def self.player_uri_path(season = TEST_SEASON, gameid = TEST_GAMEID)
        'https://api.mysportsfeeds.com/v1.1/pull/nba/' + season\
         + '/game_boxscore.json?gameid=' + gameid
      end

      private

      def call_stats_uri(uri)
        response = HTTP.headers('Authorization' => @msf_token).get(uri)
        Response.new(response).response_or_error
      end
    end
  end
end
