require 'faker'

######
# Create 10 users AND create 10 posts for each of them

## create a hashtag array

# def grab_tag
#   ht = []
#   10.times do
#     ht << Faker::Lorem.words(1).first
#   end
#   ht
# end 

5.times do 
  tag = Faker::Lorem.words(1).first
  Hashtag.create(tag: tag)
end

def get_random_hashtag
  ht = Hashtag.all
  ht.sample
end


4.times do # - Outer iterator 10 times pass block to do - first part is to create new user
  password = Faker::Lorem.characters(10) #set password attribute (10 char pw) - set as local because repeated in User.new
  u = User.new( # create a new User instance
    name: Faker::Name.name, # - assign name
    email: Faker::Internet.email, # - assign email
    password: password, # - assign local to pw
    password_confirmation: password) # - assign local to pw_conf
  # u.skip_confirmation! # - after all new user instances are created - skip the conf step to avoid sending out email
  u.save # - save users to db

  # #Inner iterator - Create 10 bookmarks per user -


  3.times do # - create 10 new bookmarks for every user
    bm = u.bookmarks.create(
      url: Faker::Internet.url,
      title: Faker::Lorem.words(rand(1..4)).join(" "),
      description: Faker::Lorem.paragraph(1)
    ) # - create a bookmark within the scope of a unique user instance    
    bm.update_attribute(:created_at, Time.now - rand(600..31536000)) # set the created_at to a time within the past year
    rand(1..3).times do
      hashtag = get_random_hashtag
      # Tagmap.first_or_create(hashtag_id: hashtag.id, bookmark_id: bm.id)
      Tagmap.create(hashtag_id: hashtag.id, bookmark_id: bm.id)
    end
  end
end

User.create(
    name: "Randal Maile", 
    email: "rmaile2000@yahoo.com", 
    password: "got2go", 
    password_confirmation: "got2go") 


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Bookmark.count} bookmarks created"
puts "#{Hashtag.count} hashtags created"
puts "#{Tagmap.count} Tagmaps created"