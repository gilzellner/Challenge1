# app.rb
require 'sinatra'
require 'open-uri'
require 'json'

GOOGLE_MAPS_API_KEY = ENV['GOOGLE_MAPS_API_KEY']
OPENWEATHER_API_KEY = ENV['OPENWEATHER_API_KEY']

def get_google_data_for_travel(origin, destination)
  url = "https://maps.googleapis.com/maps/api/directions/json?key=#{GOOGLE_MAPS_API_KEY}&origin=#{origin}&destination=#{destination}"
  response = open(url)
  # response_status = response.status
  response_body = response.read
  return JSON.parse(response_body)
end

def get_weather_data_for_travel(lat, lon)
  url = "http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&APPID=#{OPENWEATHER_API_KEY}"
  response = open(url)
  # response_status = response.status
  response_body = response.read
  return JSON.parse(response_body)
end

def get_request_metadata()
  return { "origin": params[:origin],
            "destination": params[:destination],
            "mintemp": params[:mintemp],
            "maxtemp": params[:maxtemp],
            "maxtime": params[:maxtime] }
end

class ShowRequest < Sinatra::Base
  get '/?:origin?/?:destination?/?:mintemp?/?:maxtemp?/?:maxtime?' do
    google_api_data = get_google_data_for_travel(params[:origin], params[:destination])
    weather_data = get_weather_data_for_travel(0,0)
    request_data = get_request_metadata()
    { "request_data": request_data,
       "google_api_data": google_api_data,
       "weather_data": weather_data }.to_s

  end
end

