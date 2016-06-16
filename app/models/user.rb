class User < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :recipients, dependent: :destroy
  has_many :reports, dependent: :destroy

  has_secure_password
  validates :password, confirmation: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def second_latest_report
    self.reports.order("end_date DESC").offset(1).limit(1).first
  end

  def largest_priority_number
    if self.tasks.count > 0
      self.tasks.incomplete.sort_by {|task| task.priority}.last.priority
    else
      0
    end
  end
end
