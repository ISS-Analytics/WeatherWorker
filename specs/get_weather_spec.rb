# frozen_string_literal: true

require_relative './spec_helper.rb'

describe 'GetWeatherForecast service' do
  before do
    @fake_oracle = Minitest::Mock.new
    @fake_oracle.expect :get_forecast, DARKSKY_FORECAST, [LOCATION]
  end

  it 'should be able to get an actual forecast' do
    forecasts = GetWeatherForecast.new(@fake_oracle).call(LOCATION)

    _(forecasts['daily']).wont_be_nil
    _(forecasts['daily'].count).must_equal 8

    _(forecasts['hourly']).wont_be_nil
    _(forecasts['hourly'].count).must_equal(2 * 24 + 1)
  end
end
