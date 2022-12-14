class ParkingLocation < ApplicationRecord
  has_many :parking_histories
  has_many :reports
  has_many_attached :photos
  geocoded_by :address
  has_one_attached :photo
  after_validation :geocode, if: :will_save_change_to_address?
  validates :address, presence: true
end
