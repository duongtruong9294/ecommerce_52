class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password, null: false, default: ""
      t.string :address
      t.string :phone
      t.integer :role, null: false, default: 0
      t.datetime :remember_created_at
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip
      t.timestamps
    end
  add_index :users, :email, unique: true
  end
end
