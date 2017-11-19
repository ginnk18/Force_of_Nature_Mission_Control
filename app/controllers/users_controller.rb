class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      WelcomeMailer.welcome_user(@user).deliver_now
      flash[:notice] = 'You signed up! Now go save the world!'
      redirect_to root_path

    else
      render :new
    end
  end
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
