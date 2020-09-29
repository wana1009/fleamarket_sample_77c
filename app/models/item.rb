class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :charge
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day

  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  has_many :images
  has_one :seller
  has_one :order

  validates :name, presence: true
  validates :detail, presence: true
  validates :price, presence: true
  validates :condition, presence: true
  validates :charge, presence: true
  validates :prefecture, presence: true
  validates :day, presence: true
end
