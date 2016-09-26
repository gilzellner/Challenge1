# app.rb
require 'sinatra'
require 'open-uri'
require 'json'

GOOGLE_MAPS_API_KEY = ENV['GOOGLE_MAPS_API_KEY']
OPENWEATHER_API_KEY = ENV['OPENWEATHER_API_KEY']

def get_google_data_for_travel(source, destination)
  url = "https://maps.googleapis.com/maps/api/directions/json?key=#{GOOGLE_MAPS_API_KEY}&origin=#{source}&destination=#{destination}"
  response = open(url)
  # response_status = response.status
  response_body = response.read
  return response_body
end

def get_weather_data_for_travel(lat, lon)
  url = "http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&key=#{OPENWEATHER_API_KEY}"
  response = open(url)
  # response_status = response.status
  response_body = response.read
  return response_body
end


class ShowRequest < Sinatra::Base
  get '/?:source?/?:destination?/?:mintemp?/?:maxtemp?/?:maxtime?' do
    google_api_data = get_google_data_for_travel(params[:source], params[:destination])
    weather_source = get_weather_data_for_travel()
    weather_dest = get_weather_data_for_travel()
    json_string = google_api_data.to_json.dup.encode("UTF-8")
    encoded_hash = JSON.parse(json_string).with_indifferent_access

    "source: #{params[:source]}\n destination: #{params[:destination]}\n
      mintemp: #{params[:mintemp]}\n maxtemp: #{params[:maxtemp]}\n maxtime: #{params[:maxtime]}\n
      \nGoogle API data: #{encoded_hash} \nWeather at source: #{weather_source} \nWeather at destination: #{weather_dest}"
  end
end

