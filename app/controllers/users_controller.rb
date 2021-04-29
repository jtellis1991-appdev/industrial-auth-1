class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :no_stalking, only: %i[ feed discover ]

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def no_stalking
      if current_user.username != @user.username
        redirect_back fallback_location: root_url, alert: "Unauthorized access. Don't be nosy!" 
      end
    end

end