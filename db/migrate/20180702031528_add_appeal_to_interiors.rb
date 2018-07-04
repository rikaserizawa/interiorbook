class AddAppealToInteriors < ActiveRecord::Migration[5.0]
  def change
    add_column :interiors, :appeal, :string
  end
end
