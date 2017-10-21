desc 'run test'
task :spec do
  sh 'ruby spec/nba_stats_spec.rb'
end

namespace :quality do
  task :rubocop do
    sh 'rubocop'
  end
  task :flog do
    sh 'flog lib/'
  end
  task :reek do
    sh 'reek lib/'
  end
end
