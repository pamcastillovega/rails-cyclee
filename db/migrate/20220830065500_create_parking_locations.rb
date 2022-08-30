class CreateParkingLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :parking_locations do |t|
      t.text :address

      t.timestamps
    end
  end
end
