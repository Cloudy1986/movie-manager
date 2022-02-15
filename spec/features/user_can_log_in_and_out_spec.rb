feature 'Log in and log out' do
  scenario 'user can log in successfully with correct email and password' do
    User.create(email: 'roger@example.com', password: 'bnfjksdbnjk')
    visit 'log-in'
    fill_in 'email', with: 'roger@example.com'
    fill_in 'password', with: 'bnfjksdbnjk'
    click_button 'Log in'
    expect(current_path).to eq '/movies'
    expect(page).to have_content 'You are signed in as roger@example.com'
  end

  scenario "user can't log in with incorrect email address" do
    User.create(email: 'roger@example.com', password: 'bnfjksdbnjk')
    visit 'log-in'
    fill_in 'email', with: 'incorrect@example.com'
    fill_in 'password', with: 'bnfjksdbnjk'
    click_button 'Log in'
    expect(current_path).to eq '/log-in'
    expect(page).to have_content 'Please check your email or password'
  end

  scenario "user can't log in with incorrect password" do
    User.create(email: 'roger@example.com', password: 'bnfjksdbnjk')
    visit 'log-in'
    fill_in 'email', with: 'roger@example.com'
    fill_in 'password', with: 'incorrect password'
    click_button 'Log in'
    expect(current_path).to eq '/log-in'
    expect(page).to have_content 'Please check your email or password'
  end

  scenario 'users that are not logged in can only see homepage, log in and sign up pages' do
    movie = Movie.create(title: 'Test movie title')
    visit '/movies'
    expect(current_path).to eq '/'
    visit 'movies/new'
    expect(current_path).to eq '/'
    visit "movies/#{movie.id}/edit"
    expect(current_path).to eq '/'
    visit "/movies/#{movie.id}/comments/new"
    expect(current_path).to eq '/'
  end
end
