# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do 
  factory :bookmark do
    url "http://google.com"
    title "Google"
    description "A pretty damn amazing company."
    user
  end

  factory :invalid_bookmark, parent: :bookmark do
    url "google.com"
  end
end
