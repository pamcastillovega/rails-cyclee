class Report < ApplicationRecord
  belongs_to :parking_location
  belongs_to :user
  belongs_to :parking_history
  has_many_attached :photos
end
