require 'rake/testtask'
desc 'run test'
task :spec do
  sh 'ruby spec/nba_stats_spec.rb'
end

desc 'rm vcr'
task :rmvcr do
  sh 'rm spec/fixtures/cassettes/nba_stats_api.yml'
end

<<<<<<< HEAD
desc 'default'
task :default do
  sh 'rake -T'
end

=======
>>>>>>> 4d86634d7e8bb492301c1580bff49460ce7b6ea8
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
