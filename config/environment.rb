require 'sinatra'

configure :development do
  def reload!
    # Tux reloading tip: https://github.com/cldwalker/tux/issues/3
    exec $PROGRAM_NAME, *ARGV
  end
end

configure :development, :test do
  begin
    BIGQUERY_KEYFILE = "#{File.dirname(__FILE__)}/bigquery_keyfile.json".freeze
    ENV['BIGQUERY_KEYFILE_JSON'] = File.read(BIGQUERY_KEYFILE)
  rescue => e
    puts 'Place BigQuery keyfile in config/ folder as bigquery_keyfile.json'
    puts e.inspect
  end
end
