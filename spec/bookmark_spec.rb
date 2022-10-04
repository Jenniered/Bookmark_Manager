require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark_1 = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers")
      bookmark_2 = Bookmark.create(url: "http://www.destroyallsoftware", title: "Destroy All Software")
      bookmark_3 = Bookmark.create(url: "http://www.google.com", title: "Google")
      # Add the test data
      # connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.makersacademy.com');")
      # connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
      # connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark_1.id
      expect(bookmarks.first.title).to eq "Makers"
      expect(bookmarks.first.url).to eq "http://www.makersacademy.com"
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'https://bbc.co.uk', title: 'BBC website')
      persisted_data = persisted_data(id: bookmark.id)
      
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.url).to eq 'https://bbc.co.uk'
      expect(bookmark.title).to eq 'BBC website'
    end
  end

  describe '.delete' do
    it 'deletes the given bookmark' do
      bookmark = Bookmark.create(url: 'https://bbc.co.uk', title: 'BBC website')
      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates the given bookmark' do
      bookmark = Bookmark.create(url: 'https://bbc.co.uk', title: 'BBC website')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: "http://www.snakersacademy", title: "Snakers Academy")

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq "Snakers Academy"
      expect(updated_bookmark.url).to eq "http://www.snakersacademy"
    end
  end

  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Makers Academy'
      expect(result.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create' do
    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(Bookmark.all).to be_empty
    end
  end

  let(:comment_class) { double(:comment_class) }
  describe '#comments' do
    it 'calls .where on the Comment class' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)
      # DatabaseConnection.query(
      #   "INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', $1);", [bookmark.id])
      bookmark.comments(comment_class)
      # expect(comment['text']).to eq 'Test comment'
    end
  end
end