# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_ledger, only: %i[index create index_filter]

  def index
    @transactions = @ledger.transactions.all
  end

  def all_records
    @transactions = Transaction.all
  end

  def all_records_filter
    parameters = {}
    parameters[:criteria] = params[:criteria][1..-2].split(',')
    @transactions = Transaction.filter_by_date(parameters)
    render :all_records, locals: { criteria: params[:criteria] }
  end

  def index_filter
    parameters = {}
    parameters[:criteria] = params[:criteria][1..-2].split(',')
    @transactions = Transaction.filter_by_date_and_ledger(parameters, @ledger.id)
    render :index, locals: { ledger_id: params[:ledger_id], criteria: params[:criteria] }
  end

  def new
    @transaction = Transaction.new
  end

  def create
    new_params = transaction_params
    new_params[:created_by] = @user.id
    new_params[:status] = :undetermined
    @transaction = @ledger.transactions.new(new_params)
    if @transaction.save
      redirect_to ledger_transactions_path(ledger_id: params[:ledger_id]), notice: 'Transaction Saved Successfully'
    else
      render :new, locals: { ledger_id: @ledger.id }, alert: 'Transaction Not Saved'
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    new_params = transaction_params
    new_params[:updated_by] = @user.id
    @transaction = Transaction.find(params[:id])
    if @transaction.update(new_params)
      redirect_to ledger_transactions_path(ledger_id: params[:ledger_id]), notice: 'Transaction Successfully Edited'
    else
      render :edit, locals: { id: params[:id], ledger_id: params[:ledger_id] }, alert: 'Transaction Not Edited'
    end
  end

  def delete_document
    transaction = Transaction.find(params[:id])
    transaction.update(updated_by: @user.id)
    transaction.document.purge
    redirect_to ledger_transactions_path(ledger_id: params[:ledger_id]), notice: 'Document Successfully Deleted'
  end

  def destroy
    Transaction.find(params[:id]).destroy
    redirect_to ledger_transactions_path(ledger_id: params[:ledger_id]), notice: 'Transaction Successfully Deleted'
  end

  def approval
    transaction = Transaction.find(params[:id])
    transaction.update(status: :approved, updated_by: @user.id, determined_by: @user.id,
                       determined_at: Time.zone.now)
    redirect_to ledger_transactions_path(ledger_id: params[:ledger_id]), notice: 'Approval recored successfully'
  end

  def rejection
    transaction = Transaction.find(params[:id])
    transaction.update(status: :rejected, updated_by: @user.id, determined_by: @user.id,
                       determined_at: Time.zone.now)
    redirect_to ledger_transactions_path(ledger_id: params[:ledger_id]), notice: 'Rejection recored successfully'
  end

  private

  def set_ledger
    @ledger = Ledger.find(params[:ledger_id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :sign, :description, :document)
  end
end
