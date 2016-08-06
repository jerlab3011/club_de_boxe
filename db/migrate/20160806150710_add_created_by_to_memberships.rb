class AddCreatedByToMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :memberships, :created_by, :integer
  end
end
