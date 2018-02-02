class Admin::DashboardController < Admin::ApplicationController

  before_action :find_users

  def index
    @events = Event.order(date: :desc)
    @users = User.all
    @teams = Team.all
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

    def people
      @teams = Team.all
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

      def signups
        @users = User.all
        @guest_users = User.where(user_category: @guest_id).order(created_at: :desc).page params[:page]
        # @users = User.order(:name).page params[:page]
        @teams = Team.all
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

        def teams
          @userteam = UserTeam.new
          @events = Event.order(date: :asc)
          @users = User.all
          @teams = Team.all
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

          def events
            @events = Event.order(date: :desc).page params[:page]
            # @users = User.order(:name).page params[:page]

            @stats = {
              event_count: Event.count,
              signed_up: UserEvent.count
            }

          end

    private

    def find_users
      @team_lead_id = UserCategory.where(name: 'Team Lead')
      @lead_users = User.where(user_category: @team_lead_id)
      @guest_id = UserCategory.where(name: 'Guest')
      @guest_users = User.where(user_category: @guest_id).order(created_at: :desc)
      @gen_vol_id = UserCategory.where(name: 'General Volunteer')
      @gen_vol_users = User.where(user_category: @gen_vol_id)
    end
end
