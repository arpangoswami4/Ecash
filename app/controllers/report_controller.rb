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
                
        @debited=Transaction.report_sum_by_user(false,params,@user.id)   
        @credited=Transaction.report_sum_by_user(true,params,@user.id)   
        
        @debited_all=Transaction.report_sum(false,params)   
        @credited_all=Transaction.report_sum(true,params)   
        render :report_page,locals:{month:params[:month],year:params[:year]}

    end
end