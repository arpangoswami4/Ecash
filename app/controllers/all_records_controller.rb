class AllRecordsController < ApplicationController
    def show
        @transactions=Transaction.all
    end
    def show_filter
        parameters={}
        parameters[:criteria]=params[:criteria][1..-2].split(",")
        @transactions=Transaction.where("updated_at >= ?",parameters[:criteria][1].to_datetime).where("updated_at <= ?",parameters[:criteria][3].to_datetime)
        render :show,locals:{ criteria:params[:criteria] }
    end
end