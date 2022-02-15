require 'user'

describe User do

  describe '.create' do
    it 'adds a user to the database' do
      user = User.create(email: 'bob@example.com', password: 'bfgjkerbfj')

      test_connection = PG.connect(dbname: 'movie_manager_test')
      test_result = test_connection.exec_params("SELECT * FROM users WHERE id = $1;", [user.id])
      
      expect(user).to be_a User
      expect(user.id).to eq test_result[0]['id']
      expect(user.email).to eq test_result[0]['email']
    end
  end
  
end
