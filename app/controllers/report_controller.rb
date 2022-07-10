class ReportController < ApplicationController
    before_action :redirect_index
    def redirect_index
        unless @logged_in
            render "ledgers/index"
        end
    end
    def report_page
        @generated=false
    end
    def report_generate
        @generated=true
        @debited=0
        @credited=0
        @debited_all=0
        @credited_all=0
        
        
        @debited+=Transaction.where("created_by=?",@user.id).where("EXTRACT(Year from created_at) = ?",params[:year]).where("EXTRACT(Month from created_at) = ?",params[:month]).where(sign:false).where(determination:[true,nil])
        .sum(:amount)            
        @credited+=Transaction.where("created_by=?",@user.id).where("EXTRACT(Year from created_at) = ?",params[:year]).where("EXTRACT(Month from created_at) = ?",params[:month]).where(sign:true).where(determination:[true,nil])
        .sum(:amount)
        
        @debited_all+=Transaction.all.where("EXTRACT(Year from created_at) = ?",params[:year]).where("EXTRACT(Month from created_at) = ?",params[:month]).where(sign:false).where(determination:[true,nil])
        .sum(:amount)
        @credited_all+=Transaction.all.where("EXTRACT(Year from created_at) = ?",params[:year]).where("EXTRACT(Month from created_at) = ?",params[:month]).where(sign:true).where(determination:[true,nil])
        .sum(:amount)
        render :report_page,locals:{month:params[:month],year:params[:year]}

    end
end