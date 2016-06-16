class Task < ActiveRecord::Base
  belongs_to :user
  default_scope { order("priority ASC") }

  scope :this_week, lambda { where('completion_date >= ? and completion_date <= ?', Date.today.beginning_of_week, Date.today.end_of_week) }

  scope :incomplete, lambda { where(completion_date: nil) }
end
