require 'google/cloud/bigquery'

class WeatherRepo
  attr_reader :bigquery, :dataset, :table

  module Error
    class NoConnection < StandardError; end
  end

  # Setup connection to repo with either configured or specified parameters
  #  e.g., repo = WeatherRepo.new(config: app.settings.config)
  #        repo = WeatherRepo.new(project: 'prj', dataset: 'dset', table: 'tab')
  def initialize(config: nil, project: nil, dataset: nil, table: nil)
    project ||= config.BIGQUERY_PROJECT
    dataset ||= config.BIGQUERY_DATASET
    table ||= config.BIGQUERY_TABLE

    @bigquery = Google::Cloud::Bigquery.new(project: project) if project
    @dataset = @bigquery&.dataset(dataset) if dataset
    @table = @dataset&.table(table) if table
  rescue
    raise Error::NoConnection, 'Could not connect to BigQuery'
  end

  # Streaming save to BigQuery
  #  e.g., result = repo.save(ahead: 0, summary: 'good days ahead')
  def save(params)
    @table.insert params
  end

  def create_dataset(dataset_name)
    dataset = @bigquery.create_dataset dataset_name
    dataset.tap { |d| puts "Dataset #{d.dataset_id} created." }
  end

  def create_table(dataset_name, table_name)
    dataset = @bigquery.dataset dataset_name

    table = dataset.create_table table_name do |schema|
      schema.integer 'ahead'
      schema.date 'date'
      schema.time 'time'
      schema.string 'summary'
      schema.string 'icon'
      schema.timestamp 'sunriseTime'
      schema.timestamp 'sunsetTime'
      schema.float 'moonPhase'
      schema.float 'precipIntensity'
      schema.float 'precipIntensityMax'
      schema.timestamp 'precipIntensityMaxTime'
      schema.float 'precipProbability'
      schema.string 'precipType'
      schema.float 'temperatureMin'
      schema.timestamp 'temperatureMinTime'
      schema.float 'temperatureMax'
      schema.timestamp 'temperatureMaxTime'
      schema.float 'apparentTemperatureMin'
      schema.timestamp 'apparentTemperatureMinTime'
      schema.float 'apparentTemperatureMax'
      schema.timestamp 'apparentTemperatureMaxTime'
      schema.float 'dewPoint'
      schema.float 'humidity'
      schema.float 'windSpeed'
      schema.integer 'windBearing'
      schema.string 'visibility'
      schema.float 'cloudCover'
      schema.float 'pressure'
      schema.float 'ozone'
      schema.string 'restaurant_name'
    end

    table.tap { |t| puts "Table #{t.table_id} created." }
  end
end
