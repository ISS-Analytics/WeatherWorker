require 'google/cloud/bigquery'

class WeatherRepo
  attr_reader :bigquery

  # Setup connection to repo
  #  e.g., repo = WeatherRepo.new(app.settings.config)
  def initialize(config)
    @bigquery = Google::Cloud::Bigquery.new project: config.BIGQUERY_PROJECT
  end

  # Stream a single record to BigQuery
  #  e.g., result = repo.save 'test_dataset', 'test_table', {'ahead' => 0, 'summary' => 'rainy days ahead'}
  def save(dataset_name, table_name, params)
    dataset = @bigquery.dataset dataset_name
    table = dataset.table table_name
    table.insert params
  end

  def create_dataset(dataset_name)
    dataset = @bigquery.create_dataset dataset_name
    dataset.tap { |d| puts "Dataset #{d.dataset_id} created." }
  end

  def create_table(dataset_name, table_name)
    dataset = @bigquery.dataset dataset_name

    table = dataset.create_table table_name do |schema|
      schema.integer 'ahead'
      schema.date 'time'
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
