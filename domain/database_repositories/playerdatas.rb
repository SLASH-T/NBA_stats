module NBAStats
  module Repository
    # Repository for Player Information
    class PlayerDatas
      def self.find_id(id)
        db_record = Database::PlayerOrm.first(id: id)
        rebuild_entity(db_record)
      end

      def self.find_player_name(player_name)
      	db_record = Database::PlayerOrm.first(player_name: player_name)
        rebuild_entity(db_record)
      end

      def self.create_form(entity)
      	db_player = Database::PlayerOrm.create(
      		origin_id:   entity.origin_id,
      		gameinfo_id: entity.gameinfo_id,
      		team_name:   entity.team_name,
      		player_name: entity.player_name,
      		FGM:         entity.FGM,
      		FGA:         entity.FGA,
      		FGP:         entity.FGP,
      		TPM:         entity.TPM,
      		TPP:         entity.TPP,
      		TPA:         entity.TPA,
      		FTM:         entity.FTM,
      		FTA:         entity.FTA,
      		FTP:         entity.FTP,
      		OREB:        entity.OREB,
      		DREB:        entity.DREB,
      		REB:         entity.REB,
      		AST:         entity.AST,
      		TOV:         entity.TOV,
      		STL:         entity.STL,
      		BLK:         entity.BLK,
      		PF:          entity.PF,
      		PTS:         entity.PTS,
      		PM:          entity.PM
      	)

        self.rebuild_entity(db_record)
      end

      def self.rebuild_entity(db_record)
      	return nil unless db_record

      	Entity::PlayerData.new(
      		origin_id:   db_record.origin_id,
      		gameinfo_id: db_record.gameinfo_id,
      		team_name:   db_record.team_name,
      		player_name: db_record.player_name,
      		FGM:         db_record.FGM,
      		FGA:         db_record.FGA,
      		FGP:         db_record.FGP,
      		TPM:         db_record.TPM,
      		TPP:         db_record.TPP,
      		TPA:         db_record.TPA,
      		FTM:         db_record.FTM,
      		FTA:         db_record.FTA,
      		FTP:         db_record.FTP,
      		OREB:        db_record.OREB,
      		DREB:        db_record.DREB,
      		REB:         db_record.REB,
      		AST:         db_record.AST,
      		TOV:         db_record.TOV,
      		STL:         db_record.STL,
      		BLK:         db_record.BLK,
      		PF:          db_record.PF,
      		PTS:         db_record.PTS,
      		PM:          db_record.PM
      		)
      end
    end
  end
end
