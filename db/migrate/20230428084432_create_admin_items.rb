class CreateAdminItems < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_items do |t|
      
      t.string :name, null: false
      t.string :introduction, null: false
      t.integer :price, null: false
      t.integer :genre_id, null: false

      t.timestamps
    end
  end
end
