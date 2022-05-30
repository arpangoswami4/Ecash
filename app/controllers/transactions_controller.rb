class TransactionsController < ApplicationController
    before_action :set_ledger,only: [:show,:create]
    def show
        @transactions=@ledger.transactions.all
    end
    def new
        @transaction=Transaction.new
    end
    def create       
        new_params=transaction_params
        new_params[:created_by]=@user.name
        @transaction=@ledger.transactions.new(new_params)
        if @transaction.save
            redirect_to show_transactions_all_path(ledger_id:params[:ledger_id]),notice:"Transaction Saved Successfully"
        else
            render :new
        end
    end

    def edit
        @transaction=Transaction.find(params[:transaction_id])
    end

    def update    
        new_params=transaction_params
        new_params[:updated_by]=@user.name
        @transaction=Transaction.find(params[:transaction_id])
        if @transaction.update(new_params)
            redirect_to show_transactions_all_path(ledger_id:params[:ledger_id]), notice:"Transaction Successfully Edited"
        else
            render :new
        end
    end

    def destroy
        Transaction.find(params[:transaction_id]).destroy
        redirect_to show_transactions_all_path(ledger_id:params[:ledger_id]), notice:"Transaction Successfully Deleted"
    end
    private
    def set_ledger
        @ledger=Ledger.find(params[:ledger_id])
    end
    def transaction_params
        params.require(:transaction).permit(:amount,:sign,:description)
    end

end