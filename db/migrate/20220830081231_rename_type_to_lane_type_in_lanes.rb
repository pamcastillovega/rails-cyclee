class RenameTypeToLaneTypeInLanes < ActiveRecord::Migration[7.0]
  def change
    rename_column :lanes, :type, :lane_type
  end
end
