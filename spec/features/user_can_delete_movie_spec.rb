feature 'Delete Movie' do
  
  scenario 'user can delete a movie from the list' do
    User.create(email: 'test@example.com', password: 'password123')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    click_link 'Add Movie'
    fill_in 'title', with: 'Batman Begins'
    click_button 'Submit'
    click_button 'Delete'
    expect(page).to have_content 'Movies List'
    expect(page).not_to have_content 'Batman Begins'
    expect(page).to have_content 'Movie deleted'
  end
  
end
