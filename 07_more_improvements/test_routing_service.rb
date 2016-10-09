require './routing_service.rb'
require 'test/unit'

class WeatherTest < Test::Unit::TestCase

  def test_get_celsius_from_kelvin
    kelvin=320
    assert_equal(kelvin - 273.15, get_celsius_from_kelvin(kelvin))
  end

  def test_get_weather_connectivity
    assert_nothing_raised do
      get_weather_data_for_travel(0,0)
    end
  end

  def test_is_all_weather_between_temps?
    weather_data = [get_weather_data_for_travel(35.22, 31.77)]
    puts weather_data
    mintemp=-50
    maxtemp=50
    assert_equal(is_all_weather_between_temps?(weather_data, mintemp, maxtemp), true)
  end

end
