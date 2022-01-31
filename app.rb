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
  erb :index
end

get '/movies/new' do
  erb :new
end

post '/movies' do
  Movie.create(title: params["title"])
  redirect '/movies'
end

run! if app_file == $0
end
