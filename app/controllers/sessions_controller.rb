class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:email])
    
        if user&.authenticate(params[:password])
          cookies[:location] = params[:location]
          session[:user_id] = user.id
    
          redirect_to user_path(user)
        else
          flash.now[:alert] = "Invalid email or password"
          render :new
        end
    end
    
    def destroy
        session.delete(:user_id)
        redirect_to root_path, notice: 'You have been logged out.'
    end
end
