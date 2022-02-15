feature 'Log in and log out' do
  scenario 'user can log in successfully' do

    User.create(email: 'roger@example.com', password: 'bnfjksdbnjk')
    
    visit 'log-in'
    fill_in 'email', with: 'roger@example.com'
    fill_in 'password', with: 'bnfjksdbnjk'
    click_button 'Log in'

    expect(current_path).to eq '/movies'
    expect(page).to have_content 'You are signed in as roger@example.com'
  end
end
