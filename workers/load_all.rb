# frozen_string_literal: true

folders = %w[application config domain infrastructure]
folders.each do |folder|
  require_relative "../#{folder}/init.rb"
end
