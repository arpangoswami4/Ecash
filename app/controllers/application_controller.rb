# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_current_user
  before_action :is_user_logged_in?

  def is_user_logged_in?
    render 'ledgers/index' unless @logged_in
  end

  def set_current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
      @logged_in = true
    else
      @user = nil
      @logged_in = false

    end
  end
end
