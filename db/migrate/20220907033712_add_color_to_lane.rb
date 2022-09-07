class AddColorToLane < ActiveRecord::Migration[7.0]
  def change
    add_column :lanes, :color, :string, default: "#616161"
  end
end
