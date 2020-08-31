class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true
  belongs_to_active_hash :prefecture

  validates :town, :house_number, :prefecture_id, presence: true
  validates :postal_code, presence: true,
            format: { with: /\A[0-9]{3}-[0-9]{4}\z/,
              message: "はハイフンを含めて正しく入力して下さい。"
            }
end