Rake::Task['user:seed'].invoke
User.all.each do |u|
  10.times do |i|
    u.tasks.create(name: "write the code",
                   description: "finish writing all the code for this project",
                   completed: false,
                   priority: i )
  end

  u.yearly_reports.create(
    start_date: Date.today.beginning_of_year,
    end_date: Date.today.end_of_year
  )

  u.reports.create(
    start_date: Date.today.beginning_of_week,
    end_date: Date.today.end_of_week
  )
end
