class CreateParkingHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :parking_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :parking_location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
