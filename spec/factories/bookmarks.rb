# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do 
  factory :bookmark do |f|
    f.url { Faker::Internet.url }
    f.title { Faker::Lorem.words(1).first}
    f.description { Faker::Lorem.paragraph(1) }
    f.user
  end

  factory :invalid_bookmark, parent: :bookmark do |f|
    f.url { Faker::Lorem.words(1) }
    f.title nil
    f.description nil
  end
end
