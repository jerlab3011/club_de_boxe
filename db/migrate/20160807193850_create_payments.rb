class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :created_by
      t.string :description
      t.float :amount

      t.timestamps
    end
  end
end
