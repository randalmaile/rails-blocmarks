# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do 
  factory :bookmark do
    url "http://google.com"
    user 

    factory :invalid_bookmark do
      url "google.com"
    end
  end
end
