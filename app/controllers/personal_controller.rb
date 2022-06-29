class PersonalController < ApplicationController
    before_action :redirect_index
    def redirect_index
        unless @logged_in
            render "main/index"
        end
    end
    def index
        ids=[]
        u_ids=@user.ledgers.ids
        @divider=u_ids.length
        ids+=u_ids
        Transaction.where("created_by=? ",@user.id).each do |t|
            if ids.exclude? t.ledger_id
                ids.push t.ledger_id 
            end
        end
        ids.uniq!
        @ledgers=Ledger.find(ids)
                
    end

    def new
        @ledger=Ledger.new
    end

    
    

    def create
        new_params=ledger_params
        new_params[:created_by]=@user.id
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
        new_params[:updated_by]=@user.id
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