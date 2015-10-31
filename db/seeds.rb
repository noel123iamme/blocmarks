if Rails.env.development? 
require 'faker'

# Create Users
15.times do
  user = User.new(
    name:     Faker::Name.name, 
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10),
  )
  user.skip_confirmation!
  user.save!
end
if User.where({email: 'noel.deguzman@me.com'}).count == 0
  user = User.new(
    name:     'Noel Deguzman', 
    email:    'noel.deguzman@me.com',
    password: 'helloworld'
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Topics
50.times do
  Topic.create!(
    title:    Faker::Lorem.sentence,
    user:     users.sample
  )
end
topics = Topic.all

# Create Posts
500.times do 
  bookmark = Bookmark.create!(
    user:   users.sample,
    topic:  topics.sample,
    url:    Faker::Lorem.url,
  )
end
posts = Bookmark.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"

end