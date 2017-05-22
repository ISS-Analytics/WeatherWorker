require 'sinatra'

configure :development do
  def reload!
    # Tux reloading tip: https://github.com/cldwalker/tux/issues/3
    exec $PROGRAM_NAME, *ARGV
  end
end

configure do
  DB_SCHEMA = YAML.safe_load(
    File.read("#{File.dirname(__FILE__)}/../db/schema.yml")
  )
end
