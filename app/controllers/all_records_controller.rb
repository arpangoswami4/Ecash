class AllRecordsController < ApplicationController
    before_action :redirect_index
    def redirect_index
        unless @logged_in
            render "ledgers/index"
        end
    end
    def index
        @transactions=Transaction.all
    end
    def index_filter
        parameters={}
        parameters[:criteria]=params[:criteria][1..-2].split(",")
        @transactions=Transaction.filter_by_date(parameters)
        render :index,locals:{ criteria:params[:criteria] }
    end
    
end