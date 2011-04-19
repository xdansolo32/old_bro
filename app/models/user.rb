# == Schema Information
# Schema version: 20110419003606
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  loginId    :string(255)
#  fistPumps  :integer
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :loginId
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true, :length => { :maximum => 64 }
  validates :email, :presence => true, :length => { :maximum => 64 }, 
  			:format   => { :with => email_regex }, :uniqueness => { :case_sensitive => false}
  validates :loginId, :presence => true, :length => { :maximum => 32 }
end
