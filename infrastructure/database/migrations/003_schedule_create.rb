# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:schedules) do
      primary_key :id
      String      :origin_id# , unique: true
      String      :date
      String      :location
      String      :away_team
      String      :home_team
      String      :gameplayed_tag
      String      :away_score
      String      :home_score

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
