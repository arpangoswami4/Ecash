class LedgersController < ApplicationController
    before_action :redirect_index,except: [:index]
    def redirect_index
        unless @logged_in
            render "ledgers/index"
        end
    end
    def index
        if @user
            @ledgers=Ledger.all
        end        
    end

    def new
        @ledger=Ledger.new
    end

    

    def create
        new_params=ledger_params
        new_params[:created_by]=@user.id
        @ledger=@user.ledgers.create(new_params)
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
        new_params=ledger_params
        new_params[:updated_by]=@user.id
        @ledger=Ledger.find(params[:id])
        if @ledger.update(new_params)
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