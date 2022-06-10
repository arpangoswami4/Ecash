class AllRecordsController < ApplicationController
    def show
        @transactions=Transaction.all
    end
    def show_filter
        parameters={}
        parameters[:criteria]=params[:criteria][1..-2].split(",")
        @transactions=Transaction.where("updated_at >= ?",parameters[:criteria][1].to_datetime.beginning_of_day).where("updated_at <= ?",parameters[:criteria][3].to_datetime.end_of_day)
        render :show,locals:{ criteria:params[:criteria] }
    end
end