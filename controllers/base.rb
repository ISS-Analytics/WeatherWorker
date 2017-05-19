# frozen_string_literal: true

require 'sinatra'
require 'econfig'
require 'google/cloud/bigquery'

class WeatherWeaverAPI < Sinatra::Base
  extend Econfig::Shortcut

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
  end
end
