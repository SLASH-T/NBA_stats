module NBAStats
  module Repository
    # Repository for Game Information
    class GameInfos
      def self.find_id(id)
        db_record = Database::GameInfoOrm.first(id: id)
        rebuild_entity(db_record)
      end
    end
  end
end
