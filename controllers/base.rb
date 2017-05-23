# frozen_string_literal: true

require 'sinatra'
require 'econfig'

# Web API to retrieve and store weather forecast information
class WeatherWeaverAPI < Sinatra::Base
  extend Econfig::Shortcut
  enable :logging

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
  end

  before do
    @oracle = WeatherOracle.new(api_key: settings.config.DARKSKY_API_KEY)
    @repo = WeatherRepo.new(project: settings.config.BIGQUERY_PROJECT,
                            dataset: settings.config.BIGQUERY_DATASET)
  end

  get '/' do
    content_type 'application/json'
    { message: 'service is up and running; connections found' }.to_json
  end
end
