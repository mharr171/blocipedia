require 'random_data'
require 'faker'
%w[standard premium admin].each do |role|
  Role.find_or_create_by(name: role)
end

Faker::Internet.unique.clear

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

# Create Standard Account
standard_member = User.new(
  name:     'Standard Account User',
  email:    'standard@blocipedia.com',
  password: 'asdf123'
)
standard_member.role = Role.find_by_name('standard')
standard_member.skip_confirmation!
standard_member.save!
print '.'

# Create Premium Account
premium_member = User.new(
  name:     'Premium Account User',
  email:    'premium@blocipedia.com',
  password: 'asdf123'
)
premium_member.role = Role.find_by_name('premium')
premium_member.skip_confirmation!
premium_member.save!
print '.'

# Create Admin Account
admin_member = User.new(
  name:     'Admin Account User',
  email:    'admin@blocipedia.com',
  password: 'asdf123'
)
admin_member.role = Role.find_by_name('admin')
admin_member.skip_confirmation!
admin_member.save!
print '.'

300.times do
  n = Faker::Internet.unique.user_name
  User.create!(
    name:     n,
    email:    Faker::Internet.safe_email(n),
    password: Faker::Internet.password
  )
  print '.'
end

# Print total number of users
users = User.all
puts "\n#{User.count} users created"

# Create Wikis
count = 0
10.times do
  count += 1
  @b = []
  5.times do
    @b << "\n" + Faker::Markdown.unique.headers + ' ' + Faker::Lorem.sentence + "\n"
    @b << Faker::Lorem.unique.paragraphs(2..8)
  end

  @u = users.sample
  @u = users.where(email:'premium@blocipedia.com').first if (count%3 == 0)
  @t = false
  @t = true if (count%3 == 0)
  w = Wiki.create!(
    title:    Faker::Vehicle.unique.manufacture.downcase.titleize,
    body:     @b.join(' '),
    private:  @t,
    user:     @u
  )
  if w.private == true
    w.collaborators << Collaborator.create!(
      user: User.all.where(email: 'standard@blocipedia.com').first,
      wiki: w
    )
  end
  print '.'
end
wikis = Wiki.all
puts "\n#{Wiki.count} wikis created"
