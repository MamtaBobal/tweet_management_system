FactoryBot.define do
  factory :tweeet do
    tweet                         { Faker::Book.title }
    user
  end
end
