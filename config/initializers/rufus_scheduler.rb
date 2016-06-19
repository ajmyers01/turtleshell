require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.cron '00 6 * * 1' do
  Rails.logger.info "Generating reports"
  Report.generate_reports
end

scheduler.cron '00 10 * * 1' do
  Rails.logger.info "Sending Weekly Report Emails"
  Report.send_reports
end

# First of the Year create new annual reports
scheduler.cron '0 0 1 1 *' do
  Rails.logger.info "Generating reports"
  YearlyReport.generate_reports
end

#scheduler.join
