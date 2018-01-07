module NBAStats
  module Repository
    # Repository for Player Information
    class PlayerDatas
      # def self.find_id(id)
      #  db_record = Database::PlayerOrm.first(id: id)
      #  rebuild_entity(db_record)
      # end

      def self.find(entity)
        find_id(entity.game_id)
      end

      def self.find_one(entity)
        db_record = Database::PlayerOrm.first(game_id: entity[0].game_id)
        rebuild_entity(db_record)
      end

      def self.find_id(game_id)
        Database::PlayerOrm.where(game_id: game_id).all.map { |db_record|
          rebuild_entity(db_record) }
      end

      def self.find_player_name(player_name)
        db_record = Database::PlayerOrm.first(player_name: player_name)
        rebuild_entity(db_record)
      end

      def self.find_or_create(entity)
        (find_id(entity.game_id) && find_player_name(entity.player_name)) || create_form(entity)
      end

      def self.create_form(entity, rank)
        #raise 'Repo already exists' if find_id(entity.game_id) && find_player_name(entity.player_name)
        puts "entity"
        puts entity
        db_gameinfo = Database::GameInfoOrm.find_or_create(origin_id: entity.game_id)
        puts "db_game"
        puts db_gameinfo
        puts "rank"
        puts rank
        db_player = Database::PlayerOrm.create(
          origin_id:   entity.origin_id,
          gameinfo_id: db_gameinfo.id,
          game_id:     entity.game_id,
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
          PM:          entity.PM,
          RK:          rank
        )
        self.rebuild_entity(db_player)
      end

      def self.rebuild_entity(db_record)
        puts "GG"
        puts db_record
        puts "db_record"
        return nil unless db_record
        puts "in"
        puts db_record
        Entity::PlayerData.new(
          id: db_record.id,
          origin_id:   db_record.origin_id,
          gameinfo_id: db_record.gameinfo_id,
          game_id:     db_record.game_id,
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
          PM:          db_record.PM,
          RK:          db_record.RK
          )
      end
    end
  end
end
