require 'random_data'
require 'faker'
['standard', 'premium', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

# Create My Account
my_account = User.new(
  name:     'Matthew',
  email:    'mharr171.z@gmail.com',
  password: 'asdf123'
)
my_account.role = Role.find_by_name('admin')
my_account.skip_confirmation!
my_account.save!
print '.'

# Create Member Account
member = User.new(
  name:     'Member User',
  email:    'member@blocipedia.com',
  password: 'asdf123'
)
member.role = Role.find_by_name('standard')
member.skip_confirmation!
member.save!
print '.'

5.times do
  User.create!(
    name:     Faker::Internet.user_name,
    email:    Faker::Internet.safe_email,
    password: Faker::Internet.password
  )
  print '.'
end

# Print total number of users
users = User.all
puts "\n#{User.count} users created"

# Create Wikis
10.times do
  Wiki.create!(
    title:    Faker::Vehicle.unique.manufacture.downcase.titleize,
    body:     Faker::Lorem.paragraphs(50).join(' '),
    private:  false,
    user:     users.sample
  )
  print '.'
end
wikis = Wiki.all
puts "\n#{Wiki.count} wikis created"
