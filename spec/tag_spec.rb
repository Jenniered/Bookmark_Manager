require 'tag'
require 'bookmark'
require 'database_helpers'

describe Tag do
  describe '.create' do
    it 'creates a new Tag object' do
      tag = Tag.create(content: 'test tag')

      # persisted_data = persisted_data(id: tag.id, table: 'tags')
      tags = DatabaseConnection.query("SELECT * FROM tags WHERE id = $1;", [tag.id])

      expect(tag).to be_a Tag
      expect(tag.id).to eq tags.first['id']
      expect(tag.content).to eq 'test tag'
    end
  end
end