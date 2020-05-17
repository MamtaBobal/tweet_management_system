FactoryBot.define do
  factory :user do
    first_name                         { Faker::Name.name }
    last_name                          { Faker::Name.name }
    email                              { Faker::Internet.email }
    password                           { 123456 }
    is_admin                           { 0 }
    organization
  end
end
