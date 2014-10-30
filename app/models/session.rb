# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  session_token :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#  environment   :string(255)      not null
#  location      :string(255)      not null
#

class Session < ActiveRecord::Base
  validates :user_id, :session_token, :environment, presence: true
  validates :session_token, uniqueness: true
  after_initialize :ensure_session_token
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
  def novel_session(user_id, environment, location)
    self.location = location
    self.environment = environment
    self.user_id = user_id
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
  end
  
end
