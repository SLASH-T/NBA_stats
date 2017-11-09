module NBAStats
  module Repository
    # Repository for Game Information
    class GameInfos
      def self.find_id(id)
        db_record = Database::GameInfoOrm.first(id: id)
        rebuild_entity(db_record)
      end

      def self.find_game(game_id)
        db_record = Database::GameInfoOrm.first(origin_id: game_id)
        rebuild_entity(db_record)
      end

      def self.find_or_create(entity)
        find_game(entity.origin_id) || create_form(entity)
      end

      def self.create_form(entity)
        #raise 'game already exists' if find_game(entity.origin_id)
        db_gameinfo = Database::GameInfoOrm.create(
          origin_id: entity.origin_id,
          date: entity.date,
          location: entity.location,
          away_team: entity.away_team,
          home_team: entity.home_team,
          away_score: entity.away_score,
          home_score: entity.home_score,
          away_score_q1: entity.away_score_q1,
          away_score_q2: entity.away_score_q2,
          away_score_q3: entity.away_score_q3,
          away_score_q4: entity.away_score_q4,
          home_score_q1: entity.home_score_q1,
          home_score_q2: entity.home_score_q2,
          home_score_q3: entity.home_score_q3,
          home_score_q4: entity.home_score_q4
        )
        self.rebuild_entity(db_gameinfo)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::GameInfo.new(
          id: db_record.id,
          origin_id: db_record.origin_id,
          date: db_record.date,
          location: db_record.location,
          away_team: db_record.away_team,
          home_team: db_record.home_team,
          away_score: db_record.away_score,
          home_score: db_record.home_score,
          away_score_q1: db_record.away_score_q1,
          away_score_q2: db_record.away_score_q2,
          away_score_q3: db_record.away_score_q3,
          away_score_q4: db_record.away_score_q4,
          home_score_q1: db_record.home_score_q1,
          home_score_q2: db_record.home_score_q2,
          home_score_q3: db_record.home_score_q3,
          home_score_q4: db_record.home_score_q4
        )
      end
    end
  end
end
