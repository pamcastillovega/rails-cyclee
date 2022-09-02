class AddColumnToLanes < ActiveRecord::Migration[7.0]
  def change
    add_column :lanes, :coordinates, :string
  end
end
