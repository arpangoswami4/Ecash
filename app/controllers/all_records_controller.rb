# frozen_string_literal: true

class AllRecordsController < ApplicationController
  

  def index
    @transactions = Transaction.all
  end

  def index_filter
    parameters = {}
    parameters[:criteria] = params[:criteria][1..-2].split(',')
    @transactions = Transaction.filter_by_date(parameters)
    render :index, locals: { criteria: params[:criteria] }
  end
end
