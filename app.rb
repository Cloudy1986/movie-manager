require 'sinatra/base'
require 'sinatra/reloader'
require './lib/movie'

class MovieManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

get '/' do
  erb :homepage
end

get '/movies' do
  @movies = Movie.all
  p @movies
  erb :index
end

run! if app_file == $0
end
