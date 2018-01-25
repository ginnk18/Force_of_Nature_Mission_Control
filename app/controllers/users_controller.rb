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
    datetime = DateTime.now.strftime('%d-%m-%Y')
    @all_events = Event.order(date: :asc).limit(3)
    user = User.find session[:user_id]
    user_event_ids = UserEvent.where(user: user)
    @user_events = [];
    user_event_ids.each do |user_event|
      @user_events.push(Event.find user_event.event_id)
    end
    if current_user.user_category.name === 'Admin'
      redirect_to admin_dashboard_index_path
    else
    render '/users/dashboard/index.html.erb'
    end
  end
  
  def changestatus
    @user.user_category = UserCategory.find_by_name params["user_category"]
    @user.save
    redirect_to admin_dashboard_index_path
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
