class UsersController < ApplicationController
  skip_before_action :is_user_logged_in?
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Registered Successfully'
    else
      render :new
    end
  end
  def login; end

  def authenticate
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in Sucessfully'
    else
      flash[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
