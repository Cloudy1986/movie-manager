require 'sinatra/base'
require 'sinatra/reloader'

class MovieManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

get '/' do
  "Welcome to Movie Manager"
end

run! if app_file == $0
end
