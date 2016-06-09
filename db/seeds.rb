Rake::Task['enspire:seed_users'].invoke
me = User.find(2)
me.tasks.create(name: "write the code",
                description: "finish writing all the code for this project",
                completed: false )
