class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
    
      t.string :name, null: false
      t.string :introduction, null: false
      t.integer :price, null: false
      t.string :genre_id
      t.string :image_id
      t.boolean :is_active, default: false, null: false
      
      t.timestamps
    end
  end
end
