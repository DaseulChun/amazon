class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :body, :rating , :user

  belongs_to :user, key: :reviewer

end
