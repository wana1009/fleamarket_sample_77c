class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :charge
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day

  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_many :images

  validates :name, presence: true
  validates :detail, presence: true
  validates :price, presence: true
  validates :condition, presence: true
  validates :charge, presence: true
  validates :prefecture, presence: true
  validates :days, presence: true
end
