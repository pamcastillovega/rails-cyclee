class Report < ApplicationRecord
  belongs_to :parking_location
  belongs_to :user
  has_one_attached :photo
end
