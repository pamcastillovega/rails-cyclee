class ParkingLocation < ApplicationRecord
  has_many :parking_histories
  has_many :reports
end
