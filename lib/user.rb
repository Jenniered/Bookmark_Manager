require 'pg'
require 'bcrypt'
# require 'database_connection'

class User
  def self.create(email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (email, password) VALUES ($1, $2) RETURNING id, email;", [email, encrypted_password])
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end

  def self.find(id:)
    return nil unless id
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = $1;", [id])
    p result
    User.new(id: result[0]['id'], email: result[0]['email'])
  end
end