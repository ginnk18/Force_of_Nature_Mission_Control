class EventsController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show]
  before_action :find_event, only: [:show, :edit, :update, :destroy]
  before_action :get_categories, only: [:new, :create, :edit, :update]
  # before_action :authorize_user!, except: [:index, :show, :new, :create]

  def new
    @event = Event.new
  end

  def create
    @Event = Event.new event_params
    @Event.user = current_user # creator of Event

    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show
    @answers = @question.answers.order(created_at: :desc)
    @answer = Answer.new
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @question } # ActiveRecrod has to_json method
      # can can covert any of its objects
      # to JSON format
    end
  end

  def edit
    # @question = Question.find params[:id]
  end

  def index
    @events = Event.order(created_at: :desc)
  end

  def update
    return head :unauthorized unless can?(:update, @event)
    if @event.update event_params
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private
  def event_params
    # With this method, we will extract the parameters related to
    # question from the `params` object. And, we'll only permit
    # fields of our choice. In this case, we specifically permit
    # the fields we allow the user to edit in the new_question form.
    params.require(:event).permit(
      :name,:date,:start_time,:end_time,
      :location,:additional_info,:attachment_url,
      :event_category_id,:leader_id)


    # The `params` object is available inside all controllers. It's
    # a "hash" that holds all URL params, all fields from the form and
    # all query params. It's as if we merged `request.query`, `request.params`
    # and `request.body` from Express into one object.
  end
  def get_categories
        @event_categories = Event_category.all
    end
    def get_users
          @lead_users = Users.all
      end

  def find_event
    @event = Event.find params[:id]
  end


  # Remember that if a `before_action` callback does a `render`, `redirect_to` or
  # `head` (methods that terminate the response), it will stop the request from
  # getting to the action.
  def authorize_user!
    # binding.pry
    unless can?(:crud, @question)
      flash[:alert] = "Access Denied!"
      redirect_to root_path

      # `head` is a method similar to `render` or `redirect_to`. It finalizes
      # the response. However, it will add content to the response. It will simply
      # set the HTTP status of the response. (e.g. head :unauthorized sets the
      # the status code to 401)
      # For a list of available status code symbols to use with `head` go to:
      # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
      # head :unauthorized
    end
  end
end
