require 'pg'
require 'bcrypt'

class User

  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end

  def self.create(email:, password:)
    hashed_password = BCrypt::Password.create(password)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec_params("INSERT INTO users (email, password) VALUES ($1, $2) RETURNING id, email;", [email, hashed_password])
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.find(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec_params("SELECT * FROM users WHERE id = $1;", [id])
    return if result.any? != true
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.authenticate(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'movie_manager_test')
    else
      connection = PG.connect(dbname: 'movie_manager')
    end
    result = connection.exec_params("SELECT * FROM users WHERE email = $1;", [email])
    return if result.any? != true
    return if BCrypt::Password.new(result[0]['password']) != password
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

end
