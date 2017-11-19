require_relative '../../lib/google_calendar_helper'
class EventsController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show]
  before_action :find_event, only: [:show, :edit, :update, :destroy]
  before_action :get_categories, only: [:new, :create, :edit, :update]
  before_action :get_users, only: [:new, :create, :edit, :update]
  # before_action :authorize_user!, except: [:index, :show, :new, :create]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    @calendar_helper = GoogleCalendarHelper.new
    @calendar = @calendar_helper.calendar
        start_date = DateTime.new(@event.date.year, @event.date.month, @event.date.day, @event.start_time.hour, @event.start_time.min)
        end_date = DateTime.new(@event.date.year, @event.date.month, @event.date.day, @event.end_time.hour, @event.end_time.min)
        start_date = start_date.change(:offset => "-0800")
        end_date = end_date.change(:offset => "-0800")
        g_event = Google::Apis::CalendarV3::Event.new({
          summary: @event.name,
          location: @event.location,
          description: @event.additional_info,
          start: {
            date_time: start_date
            },
          end: {
            date_time: end_date
          }
          })
        result = @calendar.insert_event(GoogleCalendarHelper::CALENDAR_ID, g_event)
        puts "Event-ID #{result.id}"
    @event.creator_id = User.first.id #current_user # creator of Event
    @event.google_event_id = result.id
    if @event.save!
      redirect_to event_path(@event)
    else
      # flash[:notice] = @event.errors.full_message
      render :new
    end
  end

  def show
    @category=@event.event_category
    @lead=@event.lead

    # @answers = @question.answers.order(created_at: :desc)
    # @answer = Answer.new
    # respond_to do |format|
    #   format.html { render :show }
    #   format.json { render json: @question } # ActiveRecrod has to_json method
    #   # can can covert any of its objects
    #   # to JSON format
    # end
  end

  def edit

  end

  def index
    @events = Event.order(created_at: :desc)
  end

  def update
    # return head :unauthorized unless can?(:update, @event)
    if @event.update event_params
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_dashboard_index_path
  end

  def translate
      @event = Event.find_by google_event_id: params[:id]
      redirect_to event_path(@event)
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
      :event_category_id,:lead_id)
    # The `params` object is available inside all controllers. It's
    # a "hash" that holds all URL params, all fields from the form and
    # all query params. It's as if we merged `request.query`, `request.params`
    # and `request.body` from Express into one object.
  end
  def get_categories
    @event_categories = EventCategory.all
  end
  def get_users
    @lead_users = User.all
  end

  def find_event
    @event = Event.find params[:id]
  end


  # Remember that if a `before_action` callback does a `render`, `redirect_to` or
  # `head` (methods that terminate the response), it will stop the request from
  # getting to the action.
  # def authorize_user!
  #   # binding.pry
  #   unless can?(:crud, @event)
  #     flash[:alert] = "Access Denied!"
  #     redirect_to root_path

  #     # `head` is a method similar to `render` or `redirect_to`. It finalizes
  #     # the response. However, it will add content to the response. It will simply
  #     # set the HTTP status of the response. (e.g. head :unauthorized sets the
  #     # the status code to 401)
  #     # For a list of available status code symbols to use with `head` go to:
  #     # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
  #     # head :unauthorized
  #   end
  # end
end
