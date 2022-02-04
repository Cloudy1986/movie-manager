require 'comment'

describe Comment do

  describe '.create' do
    it 'creates a comment and adds it to the database' do
      movie = Movie.create(title: 'Made up movie title')

      comment = Comment.create(text: 'This is made up comment text', movie_id: movie.id)
      Comment.create(text: 'This is another made up comment text', movie_id: movie.id)
      test_connection = PG.connect(dbname: 'movie_manager_test')
      test_result = test_connection.exec_params("SELECT * FROM comments WHERE movie_id = #{movie.id};")

      # expect(test_result[0]).to be_a Comment
      expect(test_result[0]['id']).to eq comment.id
      expect(test_result[0]['text']).to eq comment.text
      expect(test_result[0]['movie_id']).to eq movie.id
    end
  end

end
