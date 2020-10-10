class Image < ApplicationRecord
  belongs_to :item

  validates :url, presence: true

  mount_uploader :url, ImageUploader
end
