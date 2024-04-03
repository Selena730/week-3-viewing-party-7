class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    user = User.new(user_params)

    if user.password == user.password_confirmation
      if user.save
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        flash[:error] = user.errors.full_messages.to_sentence
        redirect_to register_path
      end
    else
      user.errors.add(:password_confirmation, "doesn't match Password")
      flash[:error] = "Password confirmation doesn't match Password"
      redirect_to register_path
    end 
  end 

  def login_form
  end


  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 