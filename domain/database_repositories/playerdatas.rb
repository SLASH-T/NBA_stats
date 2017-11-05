module NBAStats
  module Repository
    # Repository for Player Information
    class PlayerDatas
      def self.find_id(id)
        db_record = Database::PlayerOrm.first(id: id)
        rebuild_entity(db_record)
      end

      def self.create_from(entity)
        db_collaborator = Database::PlayerOrm.create(
          origin_id: entity.origin_id,
          username: entity.username,
          email: entity.email
        )

        self.rebuild_entity(db_collaborator)
      end
    end
  end
end
