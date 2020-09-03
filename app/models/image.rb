class Image < ApplicationRecord
  belongs_to :item

  validates :url, presence: true

  mount_uploader :image, ImageUploader
end
