class TransactionsController < ApplicationController
    before_action :set_ledger,only: [:index,:create,:index_filter]
    before_action :redirect_index
    def redirect_index
        unless @logged_in
            render "ledgers/index"
        end
    end
    def index
        @transactions=@ledger.transactions.all
    end
    def index_filter
        parameters={}
        parameters[:criteria]=params[:criteria][1..-2].split(",")
        @transactions=Transaction.filter_by_date_and_ledger(parameters,@ledger.id)
        render :index,locals:{ ledger_id:params[:ledger_id],criteria:params[:criteria] }
    end
    def new
        @transaction=Transaction.new
    end
    def create       
        new_params=transaction_params
        new_params[:created_by]=@user.id
        @transaction=@ledger.transactions.new(new_params)
        if @transaction.save
            redirect_to ledger_transactions_path(ledger_id:params[:ledger_id]),notice:"Transaction Saved Successfully"
        else
            render :new
        end
    end

    def edit
        @transaction=Transaction.find(params[:id])
    end

    def update    
        new_params=transaction_params
        new_params[:updated_by]=@user.id
        @transaction=Transaction.find(params[:id])
        if @transaction.update(new_params)
            redirect_to ledger_transactions_path(ledger_id:params[:ledger_id]), notice:"Transaction Successfully Edited"
        else
            render :new
        end
    end
    def delete_document
        transaction=Transaction.find(params[:id])
        transaction.update(updated_by:@user.id)
        transaction.document.purge
        redirect_to ledger_transactions_path(ledger_id:params[:ledger_id]), notice:"Document Successfully Deleted"
    end

    def destroy
        Transaction.find(params[:id]).destroy
        redirect_to ledger_transactions_path(ledger_id:params[:ledger_id]), notice:"Transaction Successfully Deleted"
    end
    def approval
        transaction=Transaction.find(params[:id])
        transaction.update(determination:true,updated_by:@user.id,determined_by:@user.id,determined_at:Time.zone.now)
        redirect_to ledger_transactions_path(ledger_id:params[:ledger_id]), notice:"Approval recored successfully"
    end
    def rejection
        transaction=Transaction.find(params[:id])
        transaction.update(determination:false,updated_by:@user.id,determined_by:@user.id,determined_at:Time.zone.now)
        redirect_to ledger_transactions_path(ledger_id:params[:ledger_id]), notice:"Rejection recored successfully"
    end

    private
    def set_ledger
        @ledger=Ledger.find(params[:ledger_id])
    end
    def transaction_params
        params.require(:transaction).permit(:amount,:sign,:description,:document)
    end

end