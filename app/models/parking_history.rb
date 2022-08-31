class ParkingHistory < ApplicationRecord
  belongs_to :user
  belongs_to :parking_location
  has_many :reports
end
