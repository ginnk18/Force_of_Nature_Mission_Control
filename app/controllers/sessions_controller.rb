class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: sessions_params[:email])
        if user && user.authenticate(sessions_params[:password])
            session[:user_id] = user.id
            flash[:notice] = 'Welcome! Please check-out new events in events calendar'
            redirect_to root_path
        else
            flash.now[:alert] = 'Something went wrong, please try again!'
            render :new            
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: 'Signed out.'
    end

    private

    def sessions_params
        params.require(:session).permit(:email, :password)
    end 

end
