feature 'Add Movie' do
  scenario 'user can add a movie to the list of movies' do
    User.create(email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    click_link 'Add Movie'
    fill_in 'title', with: 'Platoon'
    click_button 'Submit'
    expect(page).to have_content('Platoon')
    expect(page).to have_content 'Movie added'
  end
end
