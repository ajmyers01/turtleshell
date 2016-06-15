class ReportMailer < ApplicationMailer

  def weekly_report(report, monday, tuesday, wednesday, thursday, friday, user)
    @user = user
    @report = report
    @monday = monday
    @tuesday = tuesday
    @wednesday = wednesday
    @thursday = thursday
    @friday = friday
    destination_emails = user.recipients.collect(&:email).join(",")

    mail(to: destination_emails, cc: @user.email, subject: "#{@user.full_name}'s weekly report")
  end
end
