class Report < ActiveRecord::Base
  belongs_to :user

  MONDAY = 1
  TUESDAY = 2
  WEDNESDAY = 3
  THURSDAY = 4
  FRIDAY = 5

  def clean_start_date
    start_date.strftime("%B #{start_date.day.ordinalize}, %Y")
  end

  def clean_end_date
    end_date.strftime("%B #{end_date.day.ordinalize}, %Y")
  end

  # Scheduler Methods

  def self.generate_reports

    User.all.each do |user|
      user.reports.create(
        start_date: Date.today.beginning_of_week,
        end_date: Date.today.end_of_week
      )
    end
  end

  def self.send_reports
    User.all.each do |user|
      report = user.second_latest_report
      @monday = tasks_for(Report::MONDAY, user)
      @tuesday = tasks_for(Report::TUESDAY, user)
      @wednesday = tasks_for(Report::WEDNESDAY, user)
      @thursday = tasks_for(Report::THURSDAY, user)
      @friday = tasks_for(Report::FRIDAY, user)
      ReportMailer.weekly_report(report, @monday, @tuesday, @wednesday, @thursday, @friday, user).deliver_now
    end
  end

  def self.weekday_date(weekday, user)
    weekday = Array(weekday)
    report = user.second_latest_report
    (report.start_date.to_date..report.end_date.to_date).to_a.select {|k| weekday.to_a.include?(k.wday)}
  end

  def self.tasks_for(day, user)
    user.tasks.where(completion_date: weekday_date(day, user))
  end
end
