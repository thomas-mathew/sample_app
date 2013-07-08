class AddOwnerIdToElections < ActiveRecord::Migration
  def change
    add_column :elections, :owner_id, :integer
  end
end
