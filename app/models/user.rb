# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  after_initialize :ensure_session_token
  
  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :requests,
    class_name: "CatRentalRequest",
    foreign_key: :requester_id,
    primary_key: :id
  )
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
  end
  
  def self.find_by_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)
    return @user if @user.is_password?(password)
    nil
  end
  
end
