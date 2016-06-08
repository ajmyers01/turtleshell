# Controller to handle login and logout.
class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email or password.'
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
