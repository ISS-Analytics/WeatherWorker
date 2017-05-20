# frozen_string_literal: true

require_relative './spec_helper.rb'

describe 'WeatherForecast specifications' do
  LOCATION = { 'latitude' => FORECASTS_FIXTURE['latitude'],
               'longitude' => FORECASTS_FIXTURE['latitude'] }.freeze

  before do
    @fake_oracle = Minitest::Mock.new
    @fake_oracle.expect :get_forecast, FORECASTS_FIXTURE, [LOCATION]
  end

  it 'should be able to get right content when parse response' do
    WeatherOracle.stub :new, @fake_oracle do
      forecasts = GetWeatherForecast.new(CONFIG)
                                    .call(LOCATION)

      _(forecasts['daily']).wont_be_nil
      _(forecasts['daily'].count).must_equal 8

      _(forecasts['hourly']).wont_be_nil
      _(forecasts['hourly'].count).must_equal(2 * 24 + 1)
    end
  end
end
