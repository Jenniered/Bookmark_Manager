feature 'Create a new bookmark' do
  scenario 'user adds a new bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in 'url', with: 'https://bbc.co.uk'
    fill_in 'title', with: 'BBC website'
    click_button 'Submit'
    expect(page).to have_link('BBC website', href: 'https://bbc.co.uk')
  end
end
