# Weather Weaver API

Project to create an api that collects weather forecasts for given locations, storing them in the cloud for future retrieval.

## ToDo

- /lib/weather_forecast.rb Weather forecast Library
  - Call it `WeatherForecast`
  - Will keep our code agnostic of external API
  - Should start by using Dark Sky
  - methods: initialize, get_forecast(location)

- /lib/weather_repo.rb - Data store (Google BigQuery?)
  - Define Schema
    - What to store (columns)
  - Create Library to access store (`/lib`)
    - Call it `WeatherRepo`
    - should be to store weather report, with given location details

- /lib/error_logger.rb - Errorlogger library
  - Take any error/info
  - Stores it locally (?)
  - Emails/notifies devs

- /services/remember_weather_forecast.rb - Service object to get and store
  - Call it `RememberWeatherForecast`
  - Takes: list of locations
    - injections: data repo, weather forecast library
  - Does:
    - calls forecast library to retrieve forecasts
    - uses repo library to store forecasts
    - sends notification (email?) if there is a problem?

- /config/secrets.yml - secret credentials
  - Tokens needed:
    - BigQuery
    - DarkSky

- /config/app.yml - non-secret Locations
  - temporary location list
  - Hard coded as part of repo for now
  - Later move into payload of ifttt or iron.io call
