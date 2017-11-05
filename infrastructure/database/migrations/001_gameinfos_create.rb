# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:gameinfos) do
      primary_key :id
      String      :origin_id, unique: true
      String      :game_id

      String      :date
      String      :location
      String      :away_team
      String      :home_team
      String      :away_score
      String      :home_score
      String      :away_score_q1
      String      :away_score_q2
      String      :away_score_q3
      String      :away_score_q4
      String      :home_score_q1
      String      :home_score_q2
      String      :home_score_q3
      String      :home_score_q4

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
