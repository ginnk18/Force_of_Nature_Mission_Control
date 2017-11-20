class UserteamsController < ApplicationController
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
    def userteam_params

    end
end
