class UserteamsController < ApplicationController

    before_action :find_team, only: [:create]

    def create
        new_members = params["user_team"]["user_id"]
        new_members.each_with_index do |member, index|
            if index != 0 
                member = User.find new_members[index]
                userteam = UserTeam.new(user: member, team: @team)
                if userteam.save
                    if index == new_members.length - 1
                        redirect_to admin_teams_path, notice: "You added #{new_members.length - 1} new members to #{@team.name}"
                    end
                else
                    redirect_to admin_teams_path, notice: "#{member.full_name} is already a member of #{@team.name}"
                    break
                end
            end
        end
    end

    def destroy
        userteam = UserTeam.find params[:id]
        userteam.destroy
        redirect_to admin_dashboard_index_path
    end

    def update
    end

    def edit
    end

    private

    def find_team
        @team = Team.find params[:team_id]
    end

end

# def create
#         new_guests = params["user_event"]["user_id"]
#         new_guests.each_with_index do |guest, index|
#             if index != 0
#                 guest = User.find new_guests[index]
#                 signup = UserEvent.new(user: guest, event: @event)
#                 if signup.save
#                     EventSignUpMailer.event_sign_up(@event, guest).deliver_now
#                     remind_date = DateTime.new(@event.date.year, @event.date.month, @event.date.day)
#                     ReminderMailerJob.set(wait_until: remind_date).perform_later(@event,guest)
#                     if index == new_guests.length - 1
#                         redirect_to event_path(@event), notice: "You added #{new_guests.length - 1} new guests."
#                     end
#                 else
#                     redirect_to event_path(@event), notice: "You already signed up #{guest.full_name} to this event."
#                     break
#                 end
#             end
#         end
#     end
