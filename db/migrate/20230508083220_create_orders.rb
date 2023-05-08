class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.integer :billing_amount, null: false
      t.integer :postage, null: false
      t.string :address, null: false
      t.string :postal_code, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
