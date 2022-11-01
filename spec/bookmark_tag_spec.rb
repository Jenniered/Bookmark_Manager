require 'bookmark_tag'
require 'tag'

describe BookmarkTag do
  describe '.create' do
    it 'creates a link between a bookmark and a tag' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      # DatabaseConnection.query("INSERT INTO tags (id, content) VALUES (1, 'test tag');")
      # DatabaseConnection.query("INSERT INTO bookmark_tags (bookmark_id, tag_id) VALUES ($1, 1)", [bookmark.id])

      # tag = bookmark.tags.first
      # expect(tag['content']).to eq 'test tag'
      tag = Tag.create(content: 'test tag')
      bookmark_tag = BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag.id)

      expect(bookmark_tag).to be_a BookmarkTag
      expect(bookmark_tag.tag_id).to eq tag.id 
      expect(bookmark_tag.bookmark_id).to eq bookmark.id
    end
  end
end