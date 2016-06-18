class ReportsController < ApplicationController

  def index
    @reports = current_user.reports.all.reverse
  end

  def show
    @report = Report.find(params[:id])
    @monday = tasks_for(Report::MONDAY)
    @tuesday = tasks_for(Report::TUESDAY)
    @wednesday = tasks_for(Report::WEDNESDAY)
    @thursday = tasks_for(Report::THURSDAY)
    @friday = tasks_for(Report::FRIDAY)
    @user = current_user

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name",
          template: "reports/report_pdf.html.erb",
          viewport_size: '1280x1024',
          margin: { bottom: 25, top: 25 }
      end
    end
  end

  private
  def weekday_date(weekday)
    weekday = Array(weekday)
    (@report.start_date.to_date..@report.end_date.to_date).to_a.select {|k| weekday.to_a.include?(k.wday)}
  end

  def tasks_for(day)
    current_user.tasks.where(completion_date: weekday_date(day))
  end
end
