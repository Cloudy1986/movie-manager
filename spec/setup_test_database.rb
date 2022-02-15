require 'pg'

def setup_test_database
  p "Setting up test database..."
  connection = PG.connect(dbname: 'movie_manager_test')
  connection.exec("TRUNCATE movies, comments, users;")
end
