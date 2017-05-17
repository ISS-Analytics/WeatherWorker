# frozen_string_literal: true

# require file in this folder
files = Dir.glob(File.join(File.dirname(__FILE__), '*.rb'))
files.each { |lib| require_relative lib }
