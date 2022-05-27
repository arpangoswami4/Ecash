class PersonalController < ApplicationController
    def index
        if @user
            @ledgers=@user.ledgers.all
        end        
    end

    def new
        @ledger=Ledger.new
    end

    def report_page
        @generated=false
    end
    def report_generate
        @generated=true
        @debited=0
        @credited=0
        @user.ledgers.each do |l|
            @debited+=l.transactions.where("EXTRACT(Year from updated_at) = ?",params[:year]).where("EXTRACT(Month from updated_at) = ?",params[:month]).where(sign:false)
            .sum(:amount)            
            @credited+=l.transactions.where("EXTRACT(Year from updated_at) = ?",params[:year]).where("EXTRACT(Month from updated_at) = ?",params[:month]).where(sign:true)
            .sum(:amount)
        end
        render :report_page

    end

    def create
        new_params=ledger_params
        new_params[:created_by]=@user.name
        @ledger=@user.ledgers.create(new_params)
        if @ledger.save
            redirect_to personal_path,notice:"Name Saved Successfully"
        else
            render :new
        end


    end

    def edit
        @ledger=Ledger.find(params[:ledger_id])
    end

    def update
        new_params=ledger_params
        new_params[:updated_by]=@user.name
        @ledger=Ledger.find(params[:ledger_id])
        if @ledger.update(new_params)
            redirect_to personal_path,notice:"Name Edited Successfully"
        else
            render :new
        end
    end

    def destroy
        Ledger.find(params[:ledger_id]).destroy
        redirect_to personal_path,notice:"Ledger Deleted"
    end

    private
    def ledger_params
        params.require(:ledger).permit(:name)
    end


end