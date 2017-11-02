# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:gameinfos_players) do
      foreign_key :gameinfos_id, :gameinfos
      foreign_key :players_id, :players
      primary_key [:gameinfos_id, :players_id]
      index [:gameinfos_id, :players_id]
    end
  end
end