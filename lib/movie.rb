require 'pg'

class Movie

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
      result = connection.exec("SELECT * FROM movies;")
      result.map { |movie| movie['title'] }
  end

end