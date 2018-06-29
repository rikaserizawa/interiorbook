class CreateScraps < ActiveRecord::Migration[5.0]
  def change
    create_table :scraps do |t|
      t.references :user, foreign_key: true
      t.references :interior, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :interior_id], unique: true
    end
  end
end
