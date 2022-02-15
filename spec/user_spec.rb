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

  describe '.find' do
    it 'returns a user by id' do
      user = User.create(email: 'bob@example.com', password: 'bfgjkerbfj')

      returned_user = User.find(id: user.id)
      
      expect(returned_user).to be_a User
      expect(returned_user.id).to eq user.id
      expect(returned_user.email).to eq user.email
    end
  end

  describe '.authenticate' do

    it 'returns the user if the email address is in the user table' do
      user = User.create(email: 'bob@example.com', password: 'bfgjkerbfj')
      authenticated_user = User.authenticate(email: 'bob@example.com' , password: 'bfgjkerbfj')
      expect(authenticated_user).to be_a User
      expect(authenticated_user.email).to eq user.email
      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nil if incorrect email address is used' do
      user = User.create(email: 'bob@example.com', password: 'bfgjkerbfj')
      authenticated_user = User.authenticate(email: 'wrongemail@example.com' , password: 'bfgjkerbfj')
      expect(authenticated_user).to be nil
    end

    it 'returns nil if incorrect password is used' do
      user = User.create(email: 'bob@example.com', password: 'bfgjkerbfj')
      authenticated_user = User.authenticate(email: 'bob@example.com' , password: 'incorrectpassword123')
      expect(authenticated_user).to be nil
    end
  end
  
end
