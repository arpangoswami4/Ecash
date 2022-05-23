class TransactionsController < ApplicationController
    before_action :set_ledger,only: [:show,:create]
    def show
        @transactions=@ledger.transactions.all
    end
    def new
        @transaction=Transaction.new
    end
    def create       
        @transaction=@ledger.transactions.new(transaction_params)
        if @transaction.save
            redirect_to show_transactions_path(ledger_id:params[:ledger_id]),notice:"Transaction Saved Successfully"
        else
            render :new
        end
    end

    def edit
        @transaction=Transaction.find(params[:transaction_id])
    end

    def update    
        @transaction=Transaction.find(params[:transaction_id])
        if @transaction.update(transaction_params)
            redirect_to show_transactions_path(ledger_id:params[:ledger_id]), notice:"Transaction Successfully Edited"
        else
            render :new
        end
    end

    def destroy
        Transaction.find(params[:transaction_id]).destroy
        redirect_to show_transactions_path(ledger_id:params[:ledger_id]), notice:"Transaction Successfully Deleted"
    end
    private
    def set_ledger
        @ledger=Ledger.find(params[:ledger_id])
    end
    def transaction_params
        params.require(:transaction).permit(:amount,:sign,:description)
    end

end