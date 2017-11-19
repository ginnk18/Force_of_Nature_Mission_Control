class TeamsController < ApplicationController
  def new
    @users=User.all
    @team = Team.new
  end
end
