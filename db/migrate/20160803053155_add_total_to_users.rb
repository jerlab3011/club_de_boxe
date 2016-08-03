class AddTotalToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :total, :float
  end
end
