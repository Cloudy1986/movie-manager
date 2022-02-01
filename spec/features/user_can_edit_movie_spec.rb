feature 'Edit Movie' do
  scenario 'user can edit a movie' do
    visit '/movies'
    click_link 'Add Movie'
    fill_in 'title', with: 'Batman Begins'
    click_button 'Submit'
    click_button 'Edit'
    fill_in 'title', with: 'The Dark Knight'
    click_button 'Submit'
    expect(page).to have_content 'Movies List'
    expect(page).not_to have_content 'Batman Begins'
    expect(page).to have_content 'The Dark Knight'
  end
end