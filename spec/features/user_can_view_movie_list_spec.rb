feature 'View movie list' do
  scenario 'user can view a list of movies' do
    User.create(email: 'test@example.com', password: 'password123')
    Movie.create(title: 'The Godfather')
    Movie.create(title: 'Scarface')
    Movie.create(title: 'Goodfellas')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    expect(page).to have_content("Movies List")
    expect(page).to have_content("The Godfather")
    expect(page).to have_content("Scarface")
    expect(page).to have_content("Goodfellas")
  end
end
