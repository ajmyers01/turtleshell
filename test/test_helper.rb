ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'capybara/rails'
require 'database_cleaner'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in order.
  fixtures :all

  def create_new_session(user_symbol, password)

    user = users(user_symbol)

    # save the current controller
    controller_action = @controller

    # use the sessions controller to sign in
    @controller = SessionsController.new
    post :create, session: {email: user.email,
                            password: password}

    assert_redirected_to root_path

    # restore the original controller
    @controller = controller_action

    # Return the user for further testing
    user
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
