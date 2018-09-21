class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
