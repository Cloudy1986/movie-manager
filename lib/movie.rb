require 'pg'

class Movie

  attr_reader :id, :title, :user_id

  def initialize(id:, title:, user_id:)
    @id = id
    @title = title
    @user_id = user_id
  end

  def self.find_user_movies(user_id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec("SELECT * FROM movies WHERE user_id = $1;", [user_id])
    result.map do |movie| 
      Movie.new(id: movie['id'], title: movie['title'], user_id: movie['user_id'])
    end
  end

  def self.create(title:, user_id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec("INSERT INTO movies (title, user_id) VALUES ($1, $2) RETURNING id, title, user_id;", [title, user_id])
    Movie.new(id: result[0]['id'], title: result[0]['title'], user_id: result[0]['user_id'])
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
    Movie.new(id: result[0]['id'], title: result[0]['title'], user_id: result[0]['user_id'])
  end

  def self.update(id:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec_params("UPDATE movies SET title = $1 WHERE id = $2 RETURNING id, title, user_id;", [title, id])
    Movie.new(id: result[0]['id'], title: result[0]['title'], user_id: result[0]['user_id'])
  end

  def comments(comment_class = Comment)
    comment_class.where(movie_id: id)
  end

end
