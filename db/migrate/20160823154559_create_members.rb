class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.string   "phone"
      t.string   "address"
      t.string   "postal_code"
      t.date     "birth_date"
      t.datetime "created_at",                        null: false
      t.datetime "updated_at",                        null: false
      t.string   "gender"
      t.integer  "user_id"
      t.index ["user_id"], name: "index_members_on_user_id"
      
      t.timestamps
    end
  end
end
