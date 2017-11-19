class Admin::DashboardController < Admin::ApplicationController
  def index
    @events = Event.all
    @users = User.all
    @teamlead = User.where(user_category: '3')
    @guest = User.where(user_category: '1')
    @genvol = User.where(user_category: '2')
    @stats = {
      team_count: Team.count,
      user_count: User.count,
      event_count: Event.count,
      signed_up: UserEvent.count,
      teamleads: @teamlead.count,
      guests: @guest.count,
      genvol: @genvol.count
    }

  end
end
