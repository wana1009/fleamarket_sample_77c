class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to_active_hash :condition
  belongs_to_active_hash :charge
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day

  # belongs_to :user
  belongs_to :category
  belongs_to :brand, optional: true
  has_many :images
  has_one :seller
  has_one :order

  validates :name, presence: true
  validates :detail, presence: true
  validates :price, presence: true
  validates :condition_id, presence: true
  validates :charge_id, presence: true
  validates :prefecture_id, presence: true
  validates :day_id, presence: true

  accepts_nested_attributes_for :images, allow_destroy: true
end
