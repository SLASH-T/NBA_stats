# frozen_string_literal: true

folders = %w[entities database_repositories msf_mappers values ranking]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
