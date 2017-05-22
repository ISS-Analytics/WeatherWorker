# frozen_string_literal: true

require 'google/cloud/bigquery'

# Repository class for BigQuery
class WeatherRepo
  attr_reader :bigquery, :dataset, :table

  module Error
    class NoConnection < StandardError; end
  end

  # Setup connection to repo with either configured or specified parameters
  #  e.g., repo = WeatherRepo.new(config: app.settings.config)
  #        repo = WeatherRepo.new(project: 'prj', dataset: 'dset', table: 'tab')
  def initialize(project:, dataset:, table:)
    @project = Google::Cloud::Bigquery.new(project: project) if project
    @dataset = @project.dataset(dataset) if dataset
    @table = @dataset.table(table) if table
  rescue
    raise Error::NoConnection, 'Could not connect to BigQuery'
  end

  # Streaming save to BigQuery
  #  e.g., result = repo.save(ahead: 0, summary: 'good days ahead')
  #        repo.save forecast['daily'].first
  def save(params)
    raise NoConection unless @table
    @table.insert params
  end

  def create_dataset(dataset)
    raise NoConection unless @project
    @dataset = @project.create_dataset dataset
    @dataset.tap { |d| puts "Dataset #{d.dataset_id} created." }
  end

  def create_table(table)
    raise NoConection unless @dataset
    @table = @dataset.create_table table do |schema|
      DB_SCHEMA[table].each do |name, type|
        schema.send(type, name)
      end
    end

    @table.tap { |t| puts "Table #{t.table_id} created." }
  end
end
