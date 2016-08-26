class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.references :member, foreign_key: true
      t.string :description
      t.float :price
      t.integer :duration
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :memberships, [:member_id, :created_at]
  end
end
