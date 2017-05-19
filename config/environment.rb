require 'sinatra'
require 'google/cloud/bigquery'

configure do
  BIGQUERY = Google::Cloud::Bigquery.new project: 'nthu-weather-weaver-repo'
end
