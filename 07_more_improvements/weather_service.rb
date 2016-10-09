# weather_service.rb

require 'open-uri'
require 'json'

require './utils.rb'

OPENWEATHER_API_KEY = ENV['OPENWEATHER_API_KEY']
# WEATHER_API_LIMIT = ENV['WEATHER_API_LIMIT']

class WeatherError < StandardError
  attr_reader :object

  def initialize(object)
    @object = object
  end
end


def get_weather_data_for_travel(lat, lon)
  puts('Getting Weather for lat:'+lat.to_s+' lon:'+ lon.to_s)
  url = "http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&APPID=#{OPENWEATHER_API_KEY}"
  begin
    response = open(url)
  rescue
    raise WeatherError.new(response), "Error Getting WeatherError info"
  end
  response_status = response.status
  puts response_status
  response_body = response.read
  return JSON.parse(response_body)
end

def get_celsius_from_kelvin(celsius)
  return celsius - 273.15
end

def get_all_weather_for_data(metadata)
  steps=get_nested_hash_value(metadata, 'steps')
  locations = []
  steps.each { |step| locations << {'lat': step["end_location"]["lat"], 'lng': step["end_location"]["lng"]} }
  weather_data = []
  locations.each { |location| weather_data << get_weather_data_for_travel(location[:lat], location[:lng])}
  weather_data
end

def is_all_weather_between_temps?(weatherdata, mintemp, maxtemp)
  weatherdata.each do |location|
    if (get_celsius_from_kelvin(location["main"]["temp_max"]) > maxtemp.to_f ||
        get_celsius_from_kelvin(location["main"]["temp_min"]) < mintemp.to_f)
      return false
    end
  end
  return true
end

