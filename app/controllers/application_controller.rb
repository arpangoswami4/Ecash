# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :current_user
  before_action :is_user_logged_in?
  helper_method :logged_in?,:current_user

  def is_user_logged_in?
    redirect_to root_path unless logged_in?
  end

  def current_user
    @user = session[:user_id] ? User.find(session[:user_id]) : nil  
  end

  def logged_in?
    !!current_user
  end
end
