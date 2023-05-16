class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      
      t.integer :order_id
      t.integer :item_id
      t.integer :quantity, null: false
      t.integer :making_status,default: 0,null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
