class User < ApplicationRecord
  # password
  has_secure_password
  
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :new_articles, dependent: :destroy

  # likes (many to many)
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review
  
  # Validation
  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
