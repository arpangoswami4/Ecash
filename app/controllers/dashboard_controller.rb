# frozen_string_literal: true

class DashboardController < ApplicationController
  skip_before_action :is_user_logged_in?

  def index; end

  def about; end
end
