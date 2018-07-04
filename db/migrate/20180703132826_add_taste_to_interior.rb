class AddTasteToInterior < ActiveRecord::Migration[5.0]
  def change
    add_column :interiors, :taste, :integer, default: 0
  end
end

