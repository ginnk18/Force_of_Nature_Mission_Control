class Admin::DashboardController < Admin::ApplicationController
  def index
    @events = Event.all
    @users = User.all
    @teams = Team.all
    @team_lead_id = UserCategory.where(name: 'Team Lead')
    @lead_users = User.where(user_category: @team_lead_id)
    @guest_id = UserCategory.where(name: 'Guest')
    @guest_users = User.where(user_category: @guest_id).order(created_at: :desc)
    @gen_vol_id = UserCategory.where(name: 'General Volunteer')
    @gen_vol_users = User.where(user_category: @gen_vol_id)
    @stats = {
      team_count: Team.count,
      user_count: User.count,
      event_count: Event.count,
      signed_up: UserEvent.count,
      teamleads: @lead_users.map.count,
      guests: @guest_users.map.count,
      genvol: @gen_vol_users.map.count
    }
  end
end
