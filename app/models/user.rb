class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  # has_many :cards 
  has_one :address



  validates :nickname, :email, :password, :first_name, :last_name, :first_kana, :last_kana, :birthday ,presence: true
end
