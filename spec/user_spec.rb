describe '.create' do
  it 'creates a new user' do
    user = User.create(email: "test@example.com", password: "password123")

    users = DatabaseConnection.query("SELECT * FROM users WHERE id = $1;", [user.id])

    expect(user).to be_a User
    expect(user.id).to eq users.first['id']
    expect(user.email).to eq 'test@example.com'
  end
  
  it 'hashes the password using BCrypt' do
    expect(BCrypt::Password).to receive(:create).with('password123')

    User.create(email: 'test@example.com', password: 'password123')
  end

  describe '.find' do
    it 'finds a user by ID' do
      user = User.create(email: "test@example.com", password: "password123")
      result = User.find(id: user.id)
      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end
  end

  describe '.find' do
    it 'returns nil if there is no ID given' do
      expect(User.find(id: nil)).to eq nil
    end
  end
end