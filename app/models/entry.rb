# == Schema Information
# Schema version: 20110419003606
#
# Table name: entries
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  bio                :text
#  quote              :text
#  origin             :string(255)
#  birth              :date
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class Entry < ActiveRecord::Base
	attr_accessible :photo, :name
	
	validates_attachment_presence :photo
  	validates_attachment_size :photo, :less_than => 2.megabytes 
  	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif'] 

	has_attached_file :photo, :styles => { :small => "150x150>" }
end
