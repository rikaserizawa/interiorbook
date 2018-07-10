class AddScrapsCountToInteriors < ActiveRecord::Migration[5.0]
  def self.up
    add_column :interiors, :scraps_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :interiors, :scraps_count
  end
end
