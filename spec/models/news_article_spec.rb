# require 'rails_helper'

# RSpec.describe NewsArticle, type: :model do

#   describe "validates" do
#     it("should require a title") do
#       # Given
#       news_article = NewsArticle.new
#       # When
#       news_article.valid?
#       # Then
#       expect(news_article.errors.messages).to(have_key(:title))
#     end

#     it("should have a unique title") do
#       # Given
#       persisted_na = NewsArticle.create(
#         title: "Best Pizza", description: "So tasty!"
#       )
#       na = NewsArticle.new(
#         title: persisted_na.title, description: persisted_na.description
#       )
#       # When
#       na.valid?
#       # Then
#       expect(na.errors.messages).to(have_key(:title))
#     end

#     it("should require a description") do
#       news_article = NewsArticle.new
#       news_article.valid?
#       expect(news_article.errors.messages).to(have_key(:description))
#     end
#   end

# end






