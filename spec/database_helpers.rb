require 'pg'

def persisted_data(id:)
  # connection = PG.connect(dbname: 'bookmark_manager_test')
  result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = $1;", [id])
  result.first
end
