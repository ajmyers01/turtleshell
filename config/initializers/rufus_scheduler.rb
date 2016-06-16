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

scheduler.in '3s' do
    puts '*******************************'
    puts 'Testing scheduler in production'
    puts '*******************************'
end

#scheduler.join
