require 'rake/testtask'

#desc 'run test'
#task :spec do
#  sh 'ruby spec/nba_stats_spec.rb'
#end

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
