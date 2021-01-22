class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :body, presence: true
  attachment :profile_image
end
