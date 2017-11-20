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
  def changestatus
    @user = User.find(params[:id])
    @user.user_category = UserCategory.find_by_name params["user_category"]
    @user.save
    redirect_to admin_dashboard_index_path
  end
  private
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
