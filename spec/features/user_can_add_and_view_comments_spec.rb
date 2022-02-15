feature 'Add and View comments' do
  scenario 'user can add and view comments' do
    User.create(email: 'test@example.com', password: 'password123')
    movie = Movie.create(title: 'Test movie title in feature test')
    visit '/log-in'
    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password123'
    click_button 'Log in'
    click_button 'Add comment'
    
    expect(current_path).to eq "/movies/#{movie.id}/comments/new"
    expect(page).to have_content 'Add Your Comment'

    fill_in 'comment_text', with: 'This is a comment on a movie in a feature test'
    click_button 'Submit'

    expect(current_path).to eq '/movies'
    expect(page).to have_content 'Movies List'
    expect(page).to have_content 'This is a comment on a movie in a feature test'

  end
end
