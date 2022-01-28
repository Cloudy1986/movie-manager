feature 'View movie list' do
  scenario 'user can view a list of movies' do
    visit "/"
    click_link "See Movies"
    expect(page).to have_content("Movies List")
    expect(page).to have_content("The Godfather")
    expect(page).to have_content("Scarface")
    expect(page).to have_content("Goodfellas")
  end
end
