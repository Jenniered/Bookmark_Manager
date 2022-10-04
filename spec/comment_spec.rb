require 'database_helpers'
require 'comment'
require 'bookmark'


describe Comment do
  describe ".create" do
    it 'creates a new comment' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      comment = Comment.create(text: "This is a test comment", bookmark_id: bookmark.id)

      comments = DatabaseConnection.query("SELECT * FROM comments WHERE id = $1;", [comment.id])

      expect(comment).to be_a Comment
      expect(comment.id).to eq comments.first['id']
      expect(comment.text).to eq 'This is a test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end

  describe '.where' do
    it 'gets the relevant comments from the database' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      Comment.create(text: 'This is a test comment', bookmark_id: bookmark.id)
      Comment.create(text: 'This is a second test comment', bookmark_id: bookmark.id)

      comments = Comment.where(bookmark_id: bookmark.id)
      comment = comments.first
      comment_data = DatabaseConnection.query("SELECT * FROM comments WHERE id = $1;", [comment.id])

      expect(comments.length).to eq 2
      expect(comment.id).to eq comment_data.first['id']
      expect(comment.text).to eq 'This is a test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
end

