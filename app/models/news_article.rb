class NewsArticle < ApplicationRecord
  #  In this case, if the user column is not filled, is not able to be saved? Validation failed?
  belongs_to :user
  
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
end
