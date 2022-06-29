class PersonalTransactionsController < ApplicationController
    before_action :set_ledger , only: [:show,:create,:show_filter]
    before_action :redirect_index
    def redirect_index
        unless @logged_in
            render "main/index"
        end
    end
    def show
        @transactions=@ledger.transactions.where("created_by=?",@user.id)
    end
    def show_filter
        parameters={}
        parameters[:criteria]=params[:criteria][1..-2].split(",")
        @transactions=@ledger.transactions.where("created_by=?",@user.id).where("updated_at >= ?",parameters[:criteria][1].to_datetime.beginning_of_day).where("updated_at <= ?",parameters[:criteria][3].to_datetime.end_of_day)
        render :show,locals:{ ledger_id:params[:ledger_id],criteria:params[:criteria] }
    end

    def new
        @transaction=Transaction.new
    end
    
    def create       
        new_params=transaction_params
        new_params[:created_by]=@user.id
        @transaction=@ledger.transactions.new(new_params)
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
        new_params=transaction_params
        new_params[:updated_by]=@user.id
        @transaction=Transaction.find(params[:transaction_id])
        if @transaction.update(new_params)
            redirect_to show_transactions_path(ledger_id:params[:ledger_id]), notice:"Transaction Successfully Edited"
        else
            render :new
        end
    end

    def destroy
        Transaction.find(params[:transaction_id]).destroy
        redirect_to show_transactions_path(ledger_id:params[:ledger_id]), notice:"Transaction Successfully Deleted"
    end

    def delete_document
        transaction=Transaction.find(params[:transaction_id])
        transaction.update(updated_by:@user.id)
        transaction.document.purge
        redirect_to show_transactions_path(ledger_id:params[:ledger_id]), notice:"Document Successfully Deleted"
    end
    def approval
        transaction=Transaction.find(params[:transaction_id])
        transaction.update(determination:true,determined_by:@user.id,determined_at:Time.zone.now)
        redirect_to show_transactions_path(ledger_id:params[:ledger_id]), notice:"Approval recored successfully"
    end
    def rejection
        transaction=Transaction.find(params[:transaction_id])
        transaction.update(determination:false,determined_by:@user.id,determined_at:Time.zone.now)
        redirect_to show_transactions_path(ledger_id:params[:ledger_id]), notice:"Rejection recored successfully"
    end
    private
    def set_ledger
        @ledger = Ledger.find(params[:ledger_id])
    end
    def transaction_params
        params.require(:transaction).permit(:amount,:sign,:description,:document)
    end
end