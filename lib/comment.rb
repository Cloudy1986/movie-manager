class Comment

  attr_reader :id, :text, :movie_id

  def initialize(id:, text:, movie_id:)
    @id = id
    @text = text
    @movie_id = movie_id
  end

  def self.create(text:, movie_id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec_params("INSERT INTO comments (text, movie_id) VALUES ($1, $2) RETURNING id, text, movie_id;", [text, movie_id])
    Comment.new(id: result[0]['id'], text: result[0]['text'], movie_id: result[0]['movie_id'])
  end

  def self.where(movie_id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec_params("SELECT * FROM comments WHERE movie_id = $1;", [movie_id])
    result.map do |comment|
      Comment.new(id: comment['id'], text: comment['text'], movie_id: comment['movie_id'])
    end
  end

end
