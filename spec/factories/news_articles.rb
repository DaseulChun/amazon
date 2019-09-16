FactoryBot.define do
  factory :news_article do
    sequence(:title) { |n| Faker::Food.dish + " #{n}" }
    description {Faker::Food.description}
  end
end
