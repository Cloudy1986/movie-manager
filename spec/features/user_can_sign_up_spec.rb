feature 'Sign up' do
  scenario 'user can sign up' do
    visit '/sign-up'
    fill_in 'email', with: 'feature@example.com'
    fill_in 'password', with: 'fndknjnj'
    click_button 'Sign up'

    expect(current_path).to eq '/movies'
    expect(page).to have_content 'You are signed in as feature@example.com'
  end
end
