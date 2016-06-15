class User < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :recipients, dependent: :destroy
  has_many :reports, dependent: :destroy

  has_secure_password
  validates :password, confirmation: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def secondlatestreport
    self.reports.order("end_date DESC").offset(1).limit(1).first
  end
end
