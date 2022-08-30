class AddCoordinatesToParkingLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :parking_locations, :latitude, :float
    add_column :parking_locations, :longitude, :float
  end
end
