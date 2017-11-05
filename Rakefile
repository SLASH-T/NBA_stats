require 'rake/testtask'

# desc 'run test'
# task :spec do
#  sh 'ruby spec/nba_stats_spec.rb'
# end

namespace :db do
  require_relative 'config/environment.rb'
  require 'sequel'

  Sequel.extension :migration
  app = NBAStats::Api
  desc 'run migrations'
  task :migrate do
    puts "Migrating #{app.environment} database to latest"
    Sequel::Migrator.run(app.DB, 'infrastructure/database/migrations')
  end

  desc 'Drop all tables'
  task :drop do
    require_relative 'config/environment.rb'
    app.DB.drop_table :gameinfos
    app.DB.drop_table :players
  end

  desc 'Reset all database table'
  task reset: [:drop, :migrate]
end

desc 'run tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.warning = false
end

desc 'console test'
task :console do
  sh 'pry -r ./spec/test_load_all'
end

desc 'rm vcr'
task :rmvcr do
  sh 'rm spec/fixtures/cassettes/nba_stats_api.yml'
end

desc 'default'
task :default do
  sh 'rake -T'
end

namespace :quality do
  desc 'rubocap test'
  task :rubocop do
    sh 'rubocop'
  end

  desc 'flog test'
  task :flog do
    sh 'flog lib/'
  end

  desc 'reek test'
  task :reek do
    sh 'reek lib/'
  end
end
