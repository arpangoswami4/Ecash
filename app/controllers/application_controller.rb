class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :set_current_user
    
    
    def set_current_user
        if session[:user_id]
            @user=User.find(session[:user_id])
            @logged_in=true
        else
            @user=nil
            @logged_in=false

        end
    end
end
