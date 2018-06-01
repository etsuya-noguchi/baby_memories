class Blog < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :title,presence: true
  validates :content,length: { in: 1..140 }
end
