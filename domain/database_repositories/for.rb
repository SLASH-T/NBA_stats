module NBAStats
  module Repository
    For = {
      Entity::GameInfo    => GameInfos,
      Entity::PlayerData  => PlayerDatas
    }.freeze
  end
end
