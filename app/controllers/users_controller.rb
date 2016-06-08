class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)

    if @user.save
      log_in(@user)

      flash[:success] = "#{@user.full_name} has been created."
      redirect_to root_path
    else
      flash.now[:danger] = "#{@user.errors.full_messages.to_sentence.humanize}."
      render :new
    end
  end

  def edit
    # TODO: Update to allow administrators to edit other users.
    redirect_to root_url unless params[:id].to_s == @current_user.id.to_s
    @user = @current_user
  end

  def update
    # TODO: Update to allow administrators to edit other users.
    redirect_to root_url unless params[:id].to_s == @current_user.id.to_s
    @user = @current_user

    parameters = user_params

    validated = true
    if params[:user][:old_password].present?
      parameters = parameters.merge(password_parameters)
      unless @user.authenticate(params[:user][:old_password])
        flash[:danger] = 'Password entered does not match your password.'
        validated = false
      end
    end

    # Update the user.
    if validated
      if @user.update(parameters)
        flash[:success] = 'Your settings have been updated.'
      else
        flash[:danger] = @user.errors.full_messages.to_sentence.humanize
      end
    end
    redirect_to request.referer
  end

  private

  def new_user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :phone,
                                 :password,
                                 :password_confirmation)
  end

  def user_params
    params.require(:user).permit(
      :id,
      :first_name,
      :last_name
    )
  end

  def password_parameters
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end
end
