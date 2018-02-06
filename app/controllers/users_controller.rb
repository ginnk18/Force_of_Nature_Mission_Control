class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :find_user, only: [:edit, :update, :changestatus, :contacted]
  before_action :authorize_user!, except: [:new, :create, :dashboard]

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

  def dashboard
    @events = Event.order(created_at: :desc).limit(5)
    if current_user.user_category.name === 'Admin'
      redirect_to admin_dashboard_index_path
    else
    render '/users/dashboard/index.html.erb'
    end
  end

  def changestatus
    @user.user_category = UserCategory.find_by_name params["user_category"]
    @user.save
    if @user.user_category.id == 6
    WelcomeMailer.approved(@user).deliver_now
    end
    redirect_to admin_people_path notice: "Update sucessful!"

  end

  def contacted
    @user.contacted = true
    if @user.save!
      redirect_to admin_signups_path
    else
      redirect_to admin_signups_path, notice: 'Something went wrong.'
    end
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
      :phone_number,
      :password,
      :password_confirmation
    )
  end

  def authorize_user!
    unless can?(:manage, @user)
      flash[:notice] = 'Access denied.'
      redirect_to root_path
    end
  end

end
