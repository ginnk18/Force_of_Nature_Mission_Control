class UsersController < ApplicationController
  before_action :authenticate_user!  
  before_action :find_user
  before_action :authorize_user!
  def new
    @user = User.new
  end
  def show
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
    @user.user_category = UserCategory.find_by_name params["user_category"]
    @user.save
    redirect_to admin_dashboard_index_path
  end
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to root_path, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit
  end
  private
  def find_user
    @user = User.find(params[:id])    
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
  def authorize_user!
		if current_user
			if current_user.user_category.name === 'Guest'
				flash[:notice] = 'Access denied.'
				redirect_to root_path
			end
		else
			flash[:alert] = 'Please sign in first.'
			redirect_to new_session_path
		end
  end
  
end
