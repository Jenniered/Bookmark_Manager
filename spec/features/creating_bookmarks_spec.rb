feature 'Create a new bookmark' do
  scenario 'user adds a new bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in 'url', with: 'https://bbc.co.uk'
    click_button 'Submit'
    expect(page).to have_content 'https://bbc.co.uk'
  end
end
