# frozen_string_literal: true

require 'sinatra'
require 'econfig'

configure :development do
  ENV['DATABASE_URL'] = 'sqlite://db/dev.db'

  def reload!
    # Tux reloading tip: https://github.com/cldwalker/tux/issues/3
    exec $PROGRAM_NAME, *ARGV
  end
end

class WeatherWeaverAPI < Sinatra::Base
  extend Econfig::Shortcut
  
  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
  end
end
