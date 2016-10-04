class YearlyReportsController < ApplicationController
  def index
    @reports = current_user.yearly_reports.all.reverse
  end

  def show
    @report = YearlyReport.find(params[:id])
    @tasks = current_user.tasks.where(completion_date: @report.start_date..@report.end_date)
    @user = current_user

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name",
          template: "yearly_reports/yearly_report_pdf.html.erb",
          viewport_size: '1280x1024',
          margin: { bottom: 25, top: 25 }
      end
    end
  end
end
