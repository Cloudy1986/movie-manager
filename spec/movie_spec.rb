require 'movie'

describe Movie do
  
  describe '.all' do
    it 'return a list of movies' do
      connection = PG.connect(dbname: 'movie_manager_test')
      connection.exec("INSERT INTO movies (title) VALUES ('The Godfather');")
      connection.exec("INSERT INTO movies (title) VALUES ('Scarface');")
      connection.exec("INSERT INTO movies (title) VALUES ('Goodfellas');")
      
      movies = Movie.all
      
      expect(movies.length).to eq 3
      expect(movies.first).to be_a Movie
      expect(movies[0].title).to eq "The Godfather"
      expect(movies[1].title).to eq "Scarface"
      expect(movies[2].title).to eq "Goodfellas"
    end
  end

  describe '.create' do
    it 'adds a movie to the database' do
      movie = Movie.create(title: "Platoon")
      p movie
      connection = PG.connect(dbname: 'movie_manager_test') 
      result = connection.query("SELECT * FROM movies WHERE id = #{movie.id};")
      p result[0]

      expect(movie).to be_a Movie
      expect(movie.id).to eq result[0]['id']
      expect(movie.title).to eq result[0]['title']
    end
  end

end
