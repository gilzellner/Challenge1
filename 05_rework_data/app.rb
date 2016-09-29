# app.rb
require 'sinatra'
require 'open-uri'
require 'json'

GOOGLE_MAPS_API_KEY = ENV['GOOGLE_MAPS_API_KEY']
OPENWEATHER_API_KEY = ENV['OPENWEATHER_API_KEY']
# GOOGLE_API_LIMIT = ENV['GOOGLE_API_LIMIT']
# WEATHER_API_LIMIT = ENV['WEATHER_API_LIMIT']
# THIS_SERVICE_API_LIMIT = ENV['THIS_SERVICE_API_LIMIT']

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

def get_request_data()
  return { "origin": params[:origin],
            "destination": params[:destination],
            "mintemp": params[:mintemp],
            "maxtemp": params[:maxtemp],
            "maxtime": params[:maxtime] }
end

def get_request_metadata()
  google_api_data = get_google_data_for_travel(params[:origin], params[:destination])
  weather_data = get_weather_data_for_travel(0,0)
  request_data = get_request_data()
  return { "request_data": request_data,
         "google_api_data": google_api_data,
         "weather_data": weather_data }
end

def get_response(metadata)
  {'origin': metadata[:request_data][:origin],
   'destination': metadata[:request_data][:origin],
   'totalDurationInMinutes':metadata[:google_api_data][:routes],
   'totalDistanceInMeters':68000,
   'steps':[{'duration': '5 mins',
             'end_location': {'lat': 45.5067138,
                              'lng': -73.55859149999999},
      'html_instructions': 'Keep left to continue on Autoroute 720 E',
      'weather': {'celsiusTemp': 25.3, 'description': 'scattered clouds'}},
      {'duration': '8 mins',
        'end_location': {'lat': 45.5101458, 'lng': -73.5525249},
      'html_instructions': 'Turn right onto Rue Bonsecours',
      'weather': {'celsiusTemp': -45.3, 'description': 'Not fun'}}],
      'travelAdvice': 'No',
      'metadata':metadata}
end

class ShowRequest < Sinatra::Base
  get '/?:origin?/?:destination?/?:mintemp?/?:maxtemp?/?:maxtime?' do
    # JSON.pretty_generate(get_request_metadata()[:google_api_data])
    JSON.pretty_generate(get_response(get_request_metadata()))
  end
end

