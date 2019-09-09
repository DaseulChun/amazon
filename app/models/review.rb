class Review < ApplicationRecord
  belongs_to :product

  # Validate that body is optional but the rating is required and must be a number between 1 and 5 inclusive.
  validates :rating, presence: true, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
    }
end
