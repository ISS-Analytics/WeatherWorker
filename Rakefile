# frozen_string_literal: true

require 'rake/testtask'
require './init.rb'

@config = WeatherWeaverAPI.settings.config

task default: [:spec]

desc 'Run all the tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'specs/*_spec.rb'
  t.warning = false
end

namespace :setup do
  namespace :repo do
    desc 'Create BigQuery dataset'
    task :dataset do
      dataset_fullname = "#{@config.BIGQUERY_PROJECT}:#{@config.BIGQUERY_DATASET}"
      begin
        repo = WeatherRepo.new(project: @config.BIGQUERY_PROJECT)
        repo.create_dataset @config.BIGQUERY_DATASET
        puts "Dataset #{dataset_fullname} created!"
      rescue Google::Cloud::AlreadyExistsError
        puts "Dataset #{dataset_fullname} already exists"
      end
    end

    desc 'Create BigQuery tables'
    task :create do
      db_schema = YAML.safe_load(
        File.read("#{File.dirname(__FILE__)}/db/schema.yml")
      )

      repo = WeatherRepo.new(project: @config.BIGQUERY_PROJECT,
                             dataset: @config.BIGQUERY_DATASET)
      db_schema.each do |table, schema|
        table_fullname = "#{@config.BIGQUERY_PROJECT}:#{@config.BIGQUERY_DATASET}:#{table}"
        begin
          repo.create_table(table, schema)
          puts "Table :#{table_fullname} created!"
        rescue Google::Cloud::AlreadyExistsError
          puts "Table #{table_fullname} already exists"
        end
      end
    end

    desc 'Create BigQuery dataset and tables'
    task all: [:dataset, :create]
  end

  namespace :fixture do
    task :oracle do
      @oracle = WeatherOracle.new(api_key: @config.DARKSKY_API_KEY)
    end

    desc 'Create all weather test fixtures'
    task all: [:create_raw, :create_refined]

    desc 'Create test fixture for raw weather data'
    task raw: [:oracle] do
      require 'yaml'
      FIXTURE_FILENAME = 'specs/fixtures/darksky_forecast.yml'
      raw_forecast = @oracle.get_forecast(@config.LOCATIONS.first)
      File.write(FIXTURE_FILENAME, raw_forecast.to_yaml)
      puts "DarkSky Weather forecast test fixture created at: #{FIXTURE_FILENAME}"
    end

    desc 'Create test fixture for refined weather data'
    task refined: [:oracle] do
      require 'yaml'
      FIXTURE_FILENAME = 'specs/fixtures/bigquery_forecast.yml'
      forecast = GetWeatherForecast.new(@oracle).call(@config.LOCATIONS.first)
      File.write(FIXTURE_FILENAME, forecast.to_yaml)
      puts "Refined forecast test fixture created at: #{FIXTURE_FILENAME}"
    end
  end
end
