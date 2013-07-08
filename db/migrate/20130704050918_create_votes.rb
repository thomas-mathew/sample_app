class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.decimal :quantity
      t.boolean :direction
      t.integer :user_id
      t.integer :election_id

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :election_id
    add_index :votes, [:user_id, :election_id], :unique => true
  end
end
