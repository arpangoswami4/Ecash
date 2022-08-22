# frozen_string_literal: true

class ReportController < ApplicationController
  def report_page
    @generated = false
  end

  def report_generate
    @generated = true

    @debited = Transaction.report_sum_by_user(false, params, @user.id)
    @credited = Transaction.report_sum_by_user(true, params, @user.id)

    @debited_all = Transaction.report_sum(false, params)
    @credited_all = Transaction.report_sum(true, params)
    render :report_page, locals: { month: params[:month], year: params[:year] }
  end
end
