feature "Deleting a bookmark" do
  scenario "A user can delete a bookmark" do
    Bookmark.create(url: "http://makersacademy.com", title: "Makers Academy")
    visit('/bookmarks')
    expect(page).to have_link("Makers Academy", href: "http://makersacademy.com")

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link("Makers Academy", href: "http://makersacademy.com")
  end
end