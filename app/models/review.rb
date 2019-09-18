class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  # Many to Many
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  # Validate that body is optional but the rating is required and must be a number between 1 and 5 inclusive.
  validates :rating, presence: true, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
    }
end
