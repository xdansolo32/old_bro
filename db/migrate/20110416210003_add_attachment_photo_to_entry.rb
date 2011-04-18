class AddAttachmentPhotoToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :photo_file_name, :string
    add_column :entries, :photo_content_type, :string
    add_column :entries, :photo_file_size, :integer
    add_column :entries, :photo_updated_at, :datetime
  end

  def self.down
    remove_column :entries, :photo_file_name
    remove_column :entries, :photo_content_type
    remove_column :entries, :photo_file_size
    remove_column :entries, :photo_updated_at
  end
end
