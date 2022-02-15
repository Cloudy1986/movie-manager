require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/movie'
require './lib/comment'
require './lib/user'

class MovieManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash

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
    flash[:notice_movie_added] = 'Movie added'
    redirect '/movies'
  end

  delete '/movies/:id' do
    Movie.delete(id: params['id'])
    flash[:notice_movie_deleted] = 'Movie deleted'
    redirect '/movies'
  end

  get '/movies/:id/edit' do
    @movie = Movie.find(id: params['id'])
    erb :'/movies/edit'
  end

  patch '/movies/:id' do
    Movie.update(id: params['id'], title: params['title'])
    flash[:notice_movie_updated] = 'Movie updated'
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

  get '/log-in' do
    erb :'users/log_in'
  end

  post '/log-in/new' do
    user = User.authenticate(email: params['email'], password: params['password'])
    if user
      session[:user_id] = user.id
      redirect '/movies'
    else
      flash[:notice_check_details] = 'Please check your email or password'
      redirect 'log-in'
    end
  end

  run! if app_file == $0
end
