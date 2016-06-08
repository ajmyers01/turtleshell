require 'selenium-webdriver'
require 'cucumber/rails'
require 'headless'
require 'database_cleaner'
require 'pry-rails'

Capybara.run_server = true
Capybara.server_port = 9887
Capybara.default_driver = :selenium

headless = Headless.new
at_exit do
  headless.destroy
end

Before('@selenium,@javascript', '~@no-headless') do
  headless.start if Capybara.current_driver == :selenium
end

After('@selenium,@javascript', '~@no-headless') do
  headless.stop if Capybara.current_driver == :selenium
end

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'Error has been recieved.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation
