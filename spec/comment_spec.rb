require 'comment'

describe Comment do

  describe '.create' do
    it 'creates a comment and adds it to the database' do
      user = User.create(email: 'mary@example.com', password: 'bdfbkjfdbn')
      movie = Movie.create(title: 'Made up movie title', user_id: user.id)

      comment = Comment.create(text: 'This is made up comment text', movie_id: movie.id)
      test_connection = PG.connect(dbname: 'movie_manager_test')
      test_result = test_connection.exec_params("SELECT * FROM comments WHERE movie_id = #{movie.id};")

      expect(comment).to be_a Comment
      expect(comment.id).to eq test_result[0]['id']
      expect(comment.text).to eq 'This is made up comment text'
      expect(comment.movie_id).to eq movie.id
    end
  end

  describe '.where' do
    it 'gets the relevant comments from the databse' do
      user = User.create(email: 'mary@example.com', password: 'bdfbkjfdbn')
      movie = Movie.create(title: "This is a movie title", user_id: user.id)
      Comment.create(text: 'This is a test comment', movie_id: movie.id)
      Comment.create(text: 'This is a second test comment', movie_id: movie.id)
  
      comments = Comment.where(movie_id: movie.id)
      comment = comments.first
      
      test_connection = PG.connect(dbname: 'movie_manager_test')
      test_result = test_connection.exec_params("SELECT * FROM comments WHERE id = #{comment.id};")

      expect(comments.length).to eq 2
      expect(comment.id).to eq test_result.first['id']
      expect(comment.text).to eq 'This is a test comment'
      expect(comment.movie_id).to eq movie.id
    end
  end

end
