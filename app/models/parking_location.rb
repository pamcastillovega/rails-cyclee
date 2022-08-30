class ParkingLocation < ApplicationRecord
  has_many :parking_histories
  has_many :reports
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
