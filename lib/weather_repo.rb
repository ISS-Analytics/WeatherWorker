require 'google/cloud/bigquery'

class WeatherRepo
  def self.save(dataset_name, table_name, params)
    dataset = BIGQUERY.dataset dataset_name
    table = dataset.table table_name

    row = {}
    params.keys.each do |key|
      row[key] = params[key]
    end

    table.insert row
  end

  def self.create_dataset(dataset_name)
    dataset = BIGQUERY.create_dataset dataset_name
    puts "Dataset #{dataset.dataset_id} created."
  end

  def self.create_table(dataset_name, table_name)
    dataset = BIGQUERY.dataset dataset_name

    table = dataset.create_table table_name do |schema|
      schema.date 'time', mode: :required
      schema.string 'summary', mode: :required
      schema.string 'icon', mode: :required
      schema.timestamp 'sunriseTime', mode: :required
      schema.timestamp 'sunsetTime', mode: :required
      schema.float 'moonPhase', mode: :required
      schema.float 'precipIntensity', mode: :required
      schema.float 'precipIntensityMax', mode: :required
      schema.timestamp 'precipIntensityMaxTime', mode: :required
      schema.float 'precipProbability', mode: :required
      schema.string 'precipType', mode: :required
      schema.float 'temperatureMin', mode: :required
      schema.timestamp 'temperatureMinTime', mode: :required
      schema.float 'temperatureMax', mode: :required
      schema.timestamp 'temperatureMaxTime', mode: :required
      schema.float 'apparentTemperatureMin', mode: :required
      schema.timestamp 'apparentTemperatureMinTime', mode: :required
      schema.float 'apparentTemperatureMax', mode: :required
      schema.timestamp 'apparentTemperatureMaxTime', mode: :required
      schema.float 'dewPoint', mode: :required
      schema.float 'humidity', mode: :required
      schema.float 'windSpeed', mode: :required
      schema.integer 'windBearing', mode: :required
      schema.string 'visibility', mode: :required
      schema.float 'cloudCover', mode: :required
      schema.float 'pressure', mode: :required
      schema.float 'ozone', mode: :required
      schema.string 'restaurant_name', mode: :nullable
    end

    puts "Table #{table.table_id} created."
  end
end
