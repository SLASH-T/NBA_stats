# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:players) do
      primary_key :id
      Integer     :origin_id
      foreign_key :gameinfo_id, :gameinfos

      String      :team_name
      String      :player_name
      String      :FGM
      String      :FGA
      String      :FGP
      String      :TPM
      String      :TPP
      String      :TPA
      String      :FTM
      String      :FTA
      String      :FTP
      String      :OREB
      String      :DREB
      String      :REB
      String      :AST
      String      :TOV
      String      :STL
      String      :BLK
      String      :PF
      String      :PTS
      String      :PM

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
