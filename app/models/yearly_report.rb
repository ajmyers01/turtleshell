class YearlyReport < ActiveRecord::Base
  belongs_to :user

  def clean_start_date
    start_date.strftime("%Y")
  end

  def clean_end_date
    end_date.strftime("%Y")
  end

  def self.generate_reports
    User.all.each do |user|
      user.yearly_reports.create(
        start_date: Date.today.beginning_of_year,
        end_date: Date.today.end_of_year
      )
    end
  end

  def self.tasks_for(year, user)
    user.tasks.where(completion_date: weekday_date(day, user))
  end
end
