module NBAStats
  module Repository
    # Repository for Player Information
    class Schedules
      # def self.find_id(id)
      #   db_record = Database::PlayerOrm.first(id: id)
      #   rebuild_entity(db_record)
      # end

      def self.find(entity)
        entity.each { |dates| find_schedule(dates.date) }
      end

      def self.find_schedule(date)
        Database::ScheduleOrm.where(date: date).all.map { |db_record|  rebuild_entity(db_record) }
        #db_record = Database::ScheduleOrm.first(date: date)
        #puts db_record.class
        #rebuild_entity(db_record)
      end

      def self.find_one(date)
        db_record = Database::ScheduleOrm.first(date: date[0].date)
        rebuild_entity(db_record)
      end

      def self.find_or_create(entity)
        find_schedule(entity.date) || create_form(entity)
      end

      def self.create_form(entity)
        # raise 'Repo already exists' if find_id
        # (entity.game_id) && find_player_name(entity.player_name)
        entity.each do |schedule|
          db_schedule = Database::ScheduleOrm.create(
            date:           schedule.date,
            location:       schedule.location,
            away_team:      schedule.away_team,
            home_team:      schedule.home_team,
            gameplayed_tag: schedule.gameplayed_tag,
            away_score:     schedule.away_score,
            home_score:     schedule.home_score
          )
          rebuild_entity(db_schedule)
        end
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record
        Entity::Schedule.new(
          id:              db_record.id,
          date:            db_record.date,
          location:        db_record.location,
          away_team:       db_record.away_team,
          home_team:       db_record.home_team,
          gameplayed_tag:  db_record.gameplayed_tag,
          away_score:      db_record.away_score,
          home_score:      db_record.home_score
        )
      end
    end
  end
end
