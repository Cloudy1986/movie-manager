feature 'View movie list' do
  scenario 'user can view a list of movies' do
    #Connect to the test database
    connection = PG.connect(dbname: 'movie_manager_test')
    # Add data to the test database
    connection.exec("INSERT INTO movies (title) VALUES ('The Godfather');")
    connection.exec("INSERT INTO movies (title) VALUES ('Scarface');")
    connection.exec("INSERT INTO movies (title) VALUES ('Goodfellas');")
    
    visit "/"
    click_link "See Movies"
    expect(page).to have_content("Movies List")
    expect(page).to have_content("The Godfather")
    expect(page).to have_content("Scarface")
    expect(page).to have_content("Goodfellas")
  end
end
