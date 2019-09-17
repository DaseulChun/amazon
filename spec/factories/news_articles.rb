FactoryBot.define do
  factory :news_article do
    sequence(:title) { |n| Faker::Food.dish + " #{n}" }
    description {Faker::Food.description}
    
    # create a user (using its factory)
    # associate that user to the news_article
    # otherwise, will get validation error 
    # during creating the news_article 
    association(:user, factory: :user)
  end
end
