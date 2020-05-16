class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_admin, :boolean
    add_column :users, :organization_id, :integer
  end
end
