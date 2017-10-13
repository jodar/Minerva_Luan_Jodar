FactoryGirl.define do
  factory :user do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    password  "12345678"
    birthdate "1987-02-12"
  end
end
