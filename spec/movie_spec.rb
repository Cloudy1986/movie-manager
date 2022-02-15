require 'movie'

describe Movie do
  
  describe '.find_user_movies' do
    it 'return a list of movies belonging to only that user' do
      user = User.create(email: 'bob@example.com', password: 'bfgjkerbfj')
      user2 = User.create(email: 'mary@example.com', password: 'nfjdknbj')
      movie = Movie.create(title: "The Godfather", user_id: user.id)
      movie = Movie.create(title: "Scarface", user_id: user.id)
      movie = Movie.create(title: "Goodfellas", user_id: user2.id)
      
      movies = Movie.find_user_movies(user_id: user.id)
      
      expect(movies.length).to eq 2
      expect(movies.first).to be_a Movie
      expect(movies[0].title).to eq "The Godfather"
      expect(movies[1].title).to eq "Scarface"
      expect(movies[0].user_id).to eq user.id
    end
  end

  describe '.create' do
    it 'adds a movie to the database belonging to the user' do
      user = User.create(email: 'bob@example.com', password: 'bfgjkerbfj')
      movie = Movie.create(title: "Platoon", user_id: user.id)

      connection = PG.connect(dbname: 'movie_manager_test') 
      result = connection.query("SELECT * FROM movies WHERE user_id = #{movie.user_id};")

      expect(movie).to be_a Movie
      expect(movie.id).to eq result[0]['id']
      expect(movie.title).to eq result[0]['title']
      expect(movie.user_id).to eq result[0]['user_id']
    end
  end

  describe '.delete' do
    it 'deletes a movie from the database' do
      user = User.create(email: 'mary@example.com', password: 'bdfbkjfdbn')
      movie = Movie.create(title: 'The Darn Knight', user_id: user.id)
      Movie.delete(id: movie.id)
      movies = Movie.find_user_movies(user_id: user.id)

      expect(movies.length).to eq 0
    end
  end

  describe '.find' do
    it 'retrives a movie from the database' do
      user = User.create(email: 'mary@example.com', password: 'bdfbkjfdbn')
      movie = Movie.create(title: 'Test Movie', user_id: user.id)
      movie2 = Movie.find(id: movie.id)

      expect(movie2).to be_a Movie
      expect(movie2.id).to eq movie.id
      expect(movie2.title).to eq 'Test Movie'
      expect(movie2.user_id).to eq movie.user_id
    end
  end

  describe '.update' do
    it 'updates the title of a movie' do
      user = User.create(email: 'mary@example.com', password: 'bdfbkjfdbn')
      movie = Movie.create(title: 'Test 2', user_id: user.id)
      updated_movie = Movie.update(id: movie.id, title: 'Test 3')
    
      expect(updated_movie).to be_a Movie
      expect(updated_movie.id).to eq movie.id
      expect(updated_movie.title).to_not eq movie.title
      expect(updated_movie.title).to eq 'Test 3'
      expect(updated_movie.user_id).to eq movie.user_id
    end
  end

  describe '#comments' do
    it 'returns the comments for a movie' do
      user = User.create(email: 'mary@example.com', password: 'bdfbkjfdbn')
      movie = Movie.create(title: 'Made up title', user_id: user.id)
      
      connection = PG.connect(dbname: 'movie_manager_test')
      result = connection.exec_params("INSERT INTO comments (text, movie_id) VALUES ('Made up comment text', $1);", [movie.id])

      comment = movie.comments[0]

      expect(comment.text).to eq 'Made up comment text'
    end
  end

end
