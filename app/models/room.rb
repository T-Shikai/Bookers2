class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
end
