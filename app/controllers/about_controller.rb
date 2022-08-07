# frozen_string_literal: true

class AboutController < ApplicationController
  skip_before_action :is_user_logged_in?
  def index; end
end
