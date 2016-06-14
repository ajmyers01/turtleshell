Rake::Task['enspire:seed_users'].invoke
me = User.find(2)
10.times do
me.tasks.create(name: "write the code",
                description: "finish writing all the code for this project",
                completed: false )
end
me.reports.create(
  start_date: Date.today.beginning_of_week,
  end_date: Date.today.end_of_week
)
