require 'movie'

describe Movie do
  
  describe '.all' do
    it 'return a list of movies' do
      #Connect to the test database
      connection = PG.connect(dbname: 'movie_manager_test')
      # Add data to the test database
      connection.exec("INSERT INTO movies (title) VALUES ('The Godfather');")
      connection.exec("INSERT INTO movies (title) VALUES ('Scarface');")
      connection.exec("INSERT INTO movies (title) VALUES ('Goodfellas');")
      
      movies = Movie.all
      
      expect(movies).to include "The Godfather"
      expect(movies).to include "Scarface"
      expect(movies).to include "Goodfellas"
    end
  end

end
