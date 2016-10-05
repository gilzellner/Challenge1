# app.rb
require 'sinatra'
require 'open-uri'
require 'json'
require 'byebug'
require 'recursive-open-struct'

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
  puts('Getting Weather for lat:'+lat.to_s+' lon:'+ lon.to_s)
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
  request_data = get_request_data()
  return { "request_data": request_data,
         "google_api_data": google_api_data}
end

def get_steps(metadata)
  steps=get_nested_hash_value(metadata, 'steps')
  result = []
  steps.each do |step|
    weatherdata = get_weather_data_for_travel(step["end_location"]["lat"],
                                              step["end_location"]["lng"])
    result << { "distance": step["distance"]["text"],
                "end_location": step["end_location"],
                "html_instructions":step["html_instructions"],
                "weather":
                    {"description": weatherdata["weather"][0]["description"],
                     "celsiusTemp": weatherdata["main"]["temp"]
                    }}
  end
  return result
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
    if (location["main"]["temp_max"] > maxtemp.to_f || location["main"]["temp_min"] < mintemp.to_f)
      return false
    end
  end
  return true
end

def get_nested_hash_value(obj, key)
  if obj.respond_to?(:key?) && obj.key?(key)
    return obj[key]
  elsif obj.respond_to?(:each)
    r = nil
    obj.find{ |*a| r=get_nested_hash_value(a.last, key) }
    r
  end
end

def get_response(metadata)
  openstruct_metadata = RecursiveOpenStruct.new(metadata)
  {'origin': metadata[:request_data][:origin],
   'destination': metadata[:request_data][:destination],
   'totalDurationInMinutes':get_nested_hash_value(metadata,"legs")[0]["duration"],
   'totalDistanceInMeters':openstruct_metadata.google_api_data["routes"][0]["legs"][0]["distance"]["value"],
   'steps': get_steps(metadata),
   'travelAdvice': is_all_weather_between_temps?(get_all_weather_for_data(metadata),metadata[:request_data][:mintemp],metadata[:request_data][:maxtemp])
  }
end

class ShowRequest < Sinatra::Base
  get '/?:origin?/?:destination?/?:mintemp?/?:maxtemp?/?:maxtime?' do
    metadata=get_request_metadata()
    JSON.pretty_generate(get_response(metadata))
    # byebug
  end
end

