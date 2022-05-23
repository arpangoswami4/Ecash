class MainController < ApplicationController
    
    def index
        if @user
            @ledgers=@user.ledgers.all
        end        
    end

    def new
        @ledger=Ledger.new
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
        @ledger=Ledger.find(params[:id])
    end

    def update
        @ledger=Ledger.find(params[:id])
        if @ledger.update(ledger_params)
            redirect_to root_path,notice:"Name Edited Successfully"
        else
            render :new
        end
    end

    def destroy
        Ledger.find(params[:id]).destroy
        redirect_to root_path,notice:"Ledger Deleted"
    end

    private
    def ledger_params
        params.require(:ledger).permit(:name)
    end


end