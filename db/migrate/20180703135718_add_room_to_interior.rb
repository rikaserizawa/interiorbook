class AddRoomToInterior < ActiveRecord::Migration[5.0]
  def change
    add_column :interiors, :room, :integer, default: 0
  end
end
