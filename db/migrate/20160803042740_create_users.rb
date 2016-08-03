class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :adress
      t.string :postal_code
      t.date :birth_date

      t.timestamps
    end
  end
end
