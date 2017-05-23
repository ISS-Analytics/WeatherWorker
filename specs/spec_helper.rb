# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require './init.rb'
require 'minitest/autorun'
require 'minitest/rg'

def app
  WeatherWeaverAPI
end

CONFIG = app.settings.config
DARKSKY_FIXTURE_FILE = 'specs/fixtures/darksky_forecast.yml'
REFINED_FIXTURE_FILE = 'specs/fixtures/refined_forecast.yml'

DARKSKY_FORECAST = YAML.safe_load(File.read(DARKSKY_FIXTURE_FILE))
REFINED_FORECAST = YAML.safe_load(File.read(REFINED_FIXTURE_FILE))
LOCATION = { 'latitude' => DARKSKY_FORECAST['latitude'],
             'longitude' => DARKSKY_FORECAST['latitude'] }.freeze
