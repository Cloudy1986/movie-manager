feature 'View movie list' do
  scenario 'user can view a list of movies' do
    user = User.create(email: 'test@example.com', password: 'password123')
    user2 = User.create(email: 'jerry@example.com', password: '123password')
    Movie.create(title: 'The Godfather', user_id: user.id)
    Movie.create(title: 'Scarface', user_id: user.id)
    Movie.create(title: 'Goodfellas', user_id: user2.id)
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    expect(page).to have_content("Movies List")
    expect(page).to have_content("The Godfather")
    expect(page).to have_content("Scarface")
    expect(page).to_not have_content("Goodfellas")
  end
end
