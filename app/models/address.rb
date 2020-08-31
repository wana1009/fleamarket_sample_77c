class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :postal_code, format: {with: /\A\d{3}[-]\d{4}\z/, message: "はハイフンを含めて正しく入力して下さい。"}
    validates :prefecture_id
    validates :town
    validates :postal_code
    validates :first_name
    validates :last_name
    validates :first_kana
    validates :last_kana
  end
end