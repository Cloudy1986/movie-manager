require 'sinatra/base'
require 'sinatra/reloader'
require './lib/movie'
require './lib/comment'
require './lib/user'

class MovieManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override

  get '/' do
    erb :homepage
  end

  get '/movies' do
    @user = User.find(id: session[:user_id])
    @movies = Movie.all
    erb :'/movies/index'
  end

  get '/movies/new' do
    erb :'/movies/new'
  end

  post '/movies' do
    Movie.create(title: params["title"])
    redirect '/movies'
  end

  delete '/movies/:id' do
    Movie.delete(id: params['id'])
    redirect '/movies'
  end

  get '/movies/:id/edit' do
    @movie = Movie.find(id: params['id'])
    erb :'/movies/edit'
  end

  patch '/movies/:id' do
    Movie.update(id: params['id'], title: params['title'])
    redirect '/movies'
  end

  get '/movies/:id/comments/new' do
    @movie = Movie.find(id: params['id'])
    erb :'/comments/new'
  end

  post '/movies/:id/comments' do
    Comment.create(text: params['comment_text'], movie_id: params['id'])
    redirect '/movies'
  end

  get '/sign-up' do
    erb :'users/sign_up'
  end

  post '/sign-up/new' do
    user = User.create(email: params['email'], password: params['password'])
    session[:user_id] = user.id
    redirect '/movies'
  end

  run! if app_file == $0
end
