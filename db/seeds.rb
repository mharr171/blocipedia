require 'random_data'

# Create My Account
my_account = User.new(
  name:     'Matthew',
  email:    'mharr171.z@gmail.com',
  password: 'asdf123'
)
my_account.skip_confirmation!
my_account.save!
print '.'

# Create Member Account
member = User.new(
  name:     'Member User',
  email:    'member@blocipedia.com',
  password: 'asdf123'
)
member.skip_confirmation!
member.save!
print '.'

# Print total number of users
users = User.all
puts "\n#{User.count} users created"

# Create Wikis
5.times do
  Wiki.create!(
    title:    RandomData.random_name,
    body:     RandomData.random_paragraphs,
    private:  false,
    user:     users.sample
  )
  print '.'
end
wikis = Wiki.all
puts "\n#{Wiki.count} wikis created"
