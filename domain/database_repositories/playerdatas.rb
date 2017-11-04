module NBAStats
  module Repository
    # Repository for Player Information
    class PlayerDatas
      def self.find_id(id)
        db_record = Database::PlayerOrm.first(id: id)
        rebuild_entity(db_record)
      end
    end
  end
end
