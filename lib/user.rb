require 'pg'

class User

  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end

  def self.create(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec_params("INSERT INTO users (email, password) VALUES ($1, $2) RETURNING id, email;", [email, password])
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

end
