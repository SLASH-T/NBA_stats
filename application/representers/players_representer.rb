require_relative 'player_representer'

module NBAStats
  class PlayersRepresenter < Roar::Decorator
    include Roar::JSON

    collection :players, extend: PlayerRepresenter
  end
end