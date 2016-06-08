namespace :ci do
  desc 'Continuous integration task'
  task run: [:minitest, :uitesting, :rubocop]

  task :minitest do
    sh 'bundle exec rake test RAILS_ENV=test'
  end

  task :uitesting do
    sh 'cucumber'
  end

  task :rubocop do
    sh 'rubocop -D'
  end
end
