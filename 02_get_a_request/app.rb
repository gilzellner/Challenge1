# app.rb
require 'sinatra'

class ShowRequest < Sinatra::Base
  get '/?:source?/?:destination?/?:mintemp?/?:maxtemp?/?:maxtime?' do
    "source #{params[:source]}, destination #{params[:destination]}, mintemp #{params[:mintemp]}, maxtemp #{params[:maxtemp]}, maxtime #{params[:maxtime]}"
  end
end

