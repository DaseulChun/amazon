class Product < ApplicationRecord
  
  # Associations
  has_many :reviews, dependent: :destroy
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  
  # Validations
  validates(:title, presence: true, uniqueness: { case_sensitive: false })
  validates(
    :description, presence: {message: "must exist"}, length: { minimum: 10 }
  )
  validates(:price, presence: true, numericality: { greater_than: 0 })

  # before_action
  before_validation :set_default_price
  before_save :capitalize_the_product
  
  # # Custom Getter & Setter
  # def tag_names
  #   self.tags.map{ |t| t.name }.join(", ")
  # end

  # def tag_names=(rhs)
  #   self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_name|
  #     Tag.find_or_initialize_by(name: tag_name)
  #   end
  # end

  private

  def set_default_price
    self.price ||= 1
  end

  def capitalize_the_product
    self.title.capitalize!
  end
end
