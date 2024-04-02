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

  def login_user
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      redirect_to user_path(user)
    else
      flash.now[:alert] = "Invalid email or password"
      render :login_form
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 