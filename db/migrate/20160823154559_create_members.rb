class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.references :user, foreign_key: true
      t.string   "first_name"
      t.string   "last_name"
      t.string   "phone"
      t.string   "address"
      t.string   "postal_code"
      t.date     "birth_date"
      t.datetime "created_at",                        null: false
      t.datetime "updated_at",                        null: false
      t.string   "gender"
      
      t.timestamps
    end
    add_index :members, [:user_id, :created_at]
  end
end
