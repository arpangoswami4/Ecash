class MainController < ApplicationController
    
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
        @ledger=@user.ledgers.create(ledger_params)
        if @ledger.save
            redirect_to root_path,notice:"Name Saved Successfully"
        else
            render :new
        end


    end

    def edit
        @ledger=Ledger.find(params[:ledger_id])
    end

    def update
        @ledger=Ledger.find(params[:ledger_id])
        if @ledger.update(ledger_params)
            redirect_to root_path,notice:"Name Edited Successfully"
        else
            render :new
        end
    end

    def destroy
        Ledger.find(params[:ledger_id]).destroy
        redirect_to root_path,notice:"Ledger Deleted"
    end

    private
    def ledger_params
        params.require(:ledger).permit(:name)
    end


end