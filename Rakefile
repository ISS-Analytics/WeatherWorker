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
  @config = WeatherWeaverAPI.settings.config

  task :setup_oracle do
    @oracle = WeatherOracle.new(api_key: @config.DARKSKY_API_KEY)
  end

  desc 'Create all weather test fixtures'
  task all: [:create_raw, :create_refined]

  desc 'Create test fixture for raw weather data'
  task create_raw: [:setup_oracle] do
    require 'yaml'
    FIXTURE_FILENAME = 'specs/fixtures/darksky_forecast.yml'
    raw_forecast = @oracle.get_forecast(@config.LOCATIONS.first)
    File.write(FIXTURE_FILENAME, raw_forecast.to_yaml)
    puts "DarkSky Weather forecast test fixture created at: #{FIXTURE_FILENAME}"
  end

  desc 'Create test fixture for refined weather data'
  task create_refined: [:setup_oracle] do
    require 'yaml'
    FIXTURE_FILENAME = 'specs/fixtures/bigquery_forecast.yml'
    forecast = GetWeatherForecast.new(@oracle).call(@config.LOCATIONS.first)
    File.write(FIXTURE_FILENAME, forecast.to_yaml)
    puts "Refined forecast test fixture created at: #{FIXTURE_FILENAME}"
  end
end
