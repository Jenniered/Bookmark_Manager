require 'pg'

class Bookmark
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM bookmarks;")
    result.map { |bookmark| bookmark['url'] }
  end
end
  #   [
  #     "http://www.makersacademy.com",
  #     "http://www.destroyallsoftware.com",
  #     "http://www.google.com"
  #    ]
  # end



