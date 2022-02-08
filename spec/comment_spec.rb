require 'comment'

describe Comment do

  describe '.create' do
    it 'creates a comment and adds it to the database' do
      movie = Movie.create(title: 'Made up movie title')

      comment = Comment.create(text: 'This is made up comment text', movie_id: movie.id)
      test_connection = PG.connect(dbname: 'movie_manager_test')
      test_result = test_connection.exec_params("SELECT * FROM comments WHERE movie_id = #{movie.id};")

      expect(comment).to be_a Comment
      expect(comment.id).to eq test_result[0]['id']
      expect(comment.text).to eq 'This is made up comment text'
      expect(comment.movie_id).to eq movie.id
    end
  end

end
