# frozen_string_literal: true

class LedgersController < ApplicationController
  def index
    @ledgers = Ledger.all if @user
  end

  def about; end

  def new
    @ledger = Ledger.new
  end

  def create
    new_params = ledger_params
    new_params[:created_by] = @user.id
    @ledger = @user.ledgers.create(new_params)
    if @ledger.save
      redirect_to ledgers_path, notice: 'Name Saved Successfully'
    else
      render :new, alert: 'Name not Saved'
    end
  end

  def edit
    @ledger = Ledger.find(params[:id])
  end

  def update
    new_params = ledger_params
    new_params[:updated_by] = @user.id
    @ledger = Ledger.find(params[:id])
    if @ledger.update(new_params)
      redirect_to ledgers_path, notice: 'Name Edited Successfully'
    else
      render :edit, locals: { id: params[:id] }, alert: 'Name not Edited'
    end
  end

  def destroy
    Ledger.find(params[:id]).destroy
    redirect_to ledgers_path, notice: 'Ledger Deleted'
  end

  private

  def ledger_params
    params.require(:ledger).permit(:name)
  end
end
