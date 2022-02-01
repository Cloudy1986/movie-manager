require 'pg'

class Movie

  attr_reader :id, :title

  def initialize(id:, title:)
    @id = id
    @title = title
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec("SELECT * FROM movies;")
    result.map do |movie| 
      Movie.new(id: movie['id'], title: movie['title'])
    end
  end

  def self.create(title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec("INSERT INTO movies (title) VALUES ($1) RETURNING id, title;", [title])
    Movie.new(id: result[0]['id'], title: result[0]['title'])
  end

  def self.delete(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec_params("DELETE FROM movies WHERE id = $1;", [id])
  end

  def self.find(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec_params("SELECT * FROM movies WHERE id = $1;", [id])
    Movie.new(id: result[0]['id'], title: result[0]['title'])
  end

end