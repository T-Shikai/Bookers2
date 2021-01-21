class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :email, uniqueness: true
  validates :name, {uniqueness: true, length: {in: 2..20}}
  validates :introduction, length: {maximum: 50}
  attachment :profile_image
end
