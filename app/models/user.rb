class User < ActiveRecord::Base
  has_secure_password
  validates :password, confirmation: true

  def full_name
    "#{first_name} #{last_name}"
  end
end