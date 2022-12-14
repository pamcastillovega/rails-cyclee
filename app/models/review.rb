class Review < ApplicationRecord
  belongs_to :user
  belongs_to :lane
  has_one_attached :photo
  # has_many_attached :photos
  validates :comment, :rating, presence: true
  validates :rating, numericality: { only_integer: true }
end
