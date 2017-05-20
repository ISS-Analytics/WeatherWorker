# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require './init.rb'
require 'minitest/autorun'
require 'minitest/rg'

def app
  WeatherWeaverAPI
end

CONFIG = app.settings.config
FORECASTS_FIXTURE = YAML.safe_load(File.read('specs/fixtures/forecast.yml'))
