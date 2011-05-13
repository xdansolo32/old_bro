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
  has_many :entries
  attr_accessor :password
  attr_accessible :name, :email, :loginId, :password, :password_confirmation
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  has_many :broments, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  validates :name, :presence => true, :length => { :maximum => 64 }
  validates :email, :presence => true, :length => { :maximum => 64 }, 
  			:format   => { :with => email_regex }, :uniqueness => { :case_sensitive => false}
  validates :loginId, :presence => true, :length => { :maximum => 32 }
  validates :password, :presence => true, :confirmation => true, 
  			:length => { :within => 6..40 }
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def self.search(search, page)
    paginate :per_page => PAGINATE_COUNT, :page => page,
           :conditions => ['name like ?', "%#{search}%"], :order => 'name'
  end
  
  def feed
    # This is preliminary. See Chapter 12 for the full implementation.
    Broment.where("user_id = ?", id)
  end
  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
  def feed
    Broment.from_users_followed_by(self)
  end

  PAGINATE_COUNT = 15
  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
end
