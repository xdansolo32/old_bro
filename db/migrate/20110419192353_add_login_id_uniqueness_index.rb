class AddLoginIdUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :loginId, :unique => true
  end

  def self.down
    remove_index :users, :loginId
  end
end
