class AddColumnToLanes < ActiveRecord::Migration[7.0]
  def change
    add_column :lanes, :coordinates, :string
    add_column :lanes, :objectid, :string
  end
end
