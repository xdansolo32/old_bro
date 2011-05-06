class CreateBroments < ActiveRecord::Migration
  def self.up
    create_table :broments do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :broments, :user_id
  end

  def self.down
    drop_table :broments
  end
end
