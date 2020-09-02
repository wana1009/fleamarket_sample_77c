class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user, optional: true
  belongs_to_active_hash :prefecture

  validates :first_name, :last_name, :town, :first_kana, :last_kana, :house_number, :prefecture_id, presence: true
  validates :postal_code, presence: true,
            format: {
              with: /\A[0-9]{3}-[0-9]{4}\z/,
            }
end