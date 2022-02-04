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

      connection = PG.connect(dbname: 'movie_manager_test') 
      result = connection.query("SELECT * FROM movies WHERE id = #{movie.id};")

      expect(movie).to be_a Movie
      expect(movie.id).to eq result[0]['id']
      expect(movie.title).to eq result[0]['title']
    end
  end

  describe '.delete' do
    it 'deletes a movie from the database' do
      movie = Movie.create(title: 'The Darn Knight')
      Movie.delete(id: movie.id)
      movies = Movie.all

      expect(movies.length).to eq 0
    end
  end

  describe '.find' do
    it 'retrives a movie from the database' do
      movie = Movie.create(title: 'Test Movie')
      movie2 = Movie.find(id: movie.id)

      expect(movie2).to be_a Movie
      expect(movie2.id).to eq movie.id
      expect(movie2.title).to eq 'Test Movie'
    end
  end

  describe '.update' do
    it 'updates the title of a movie' do
    movie = Movie.create(title: 'Test 2')
    updated_movie = Movie.update(id: movie.id, title: 'Test 3')
    
    expect(updated_movie).to be_a Movie
    expect(updated_movie.id).to eq movie.id
    expect(updated_movie.title).to_not eq movie.title
    expect(updated_movie.title).to eq 'Test 3'
    end
  end

  describe '#comments' do
    it 'returns the comments for a movie' do
      movie = Movie.create(title: 'Made up title')
      p movie
      
      connection = PG.connect(dbname: 'movie_manager_test')
      result = connection.exec_params("INSERT INTO comments (text, movie_id) VALUES ('Made up comment text', $1);", [movie.id])

      comment = movie.comments[0]
      p comment

      expect(comment['text']).to eq 'Made up comment text'
    end
  end

end
