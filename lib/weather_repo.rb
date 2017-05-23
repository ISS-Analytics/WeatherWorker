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
  def initialize(project: nil, dataset: nil, table: nil)
    @project = Google::Cloud::Bigquery.new(project: project) if project
    @dataset = @project.dataset(dataset) if dataset
    @table = @dataset.table(table) if table
  rescue
    raise Error::NoConnection, 'Could not connect to BigQuery'
  end

  def use_table(table)
    @table = @dataset.table(table)
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
  end

  def create_table(table_name, table_schema)
    raise NoConection unless @dataset
    @table = @dataset.create_table table_name do |schema|
      table_schema.each do |name, type|
        schema.send(type, name)
      end
    end
  end
end
