# frozen_string_literal: true

require 'rake/testtask'
require './init.rb'

task default: [:spec]

desc 'Run all the tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'specs/*_spec.rb'
  t.warning = false
end

namespace :fixture do
  task :create do
    require 'yaml'
    FIXTURE_FILENAME = 'specs/fixtures/forecast.yml'
    config = WeatherWeaverAPI.settings.config
    oracle = WeatherOracle.new(config.DARKSKY_API_KEY)
    forecast = oracle.get_forecast(config.LOCATIONS.first)
    File.write(FIXTURE_FILENAME, forecast.to_yaml)
    puts "Forecast test fixture created at: #{FIXTURE_FILENAME}"
  end
end
