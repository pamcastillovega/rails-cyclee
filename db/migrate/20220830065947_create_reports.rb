class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.text :comment
      t.date :date
      t.time :time
      t.references :parking_location, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :parking_history, null: true, foreign_key: true

      t.timestamps
    end
  end
end
