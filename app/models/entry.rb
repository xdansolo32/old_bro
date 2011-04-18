class Entry < ActiveRecord::Base
	attr_accessible :photo, :name
	
	validates_attachment_presence :photo
  	validates_attachment_size :photo, :less_than => 2.megabytes 
  	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif'] 

	has_attached_file :photo, :styles => { :small => "150x150>" }
end
