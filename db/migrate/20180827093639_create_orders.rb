class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :receiver_name
      t.string :receiver_address
      t.string :receiver_phone
      t.float :total_price
      t.integer :status, null: false, default: 0
      t.references :user, foreign_key: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
