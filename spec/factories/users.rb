# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Joe User"
    sequence(:email) { |n| "person#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
  end
end
  