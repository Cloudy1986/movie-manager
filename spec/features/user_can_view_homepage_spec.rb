feature 'Homepage' do
  scenario 'User visits homepage(/) and sees a welcome message' do
    visit '/'
    expect(page).to have_content("Welcome to Movie Manager")
  end
end
