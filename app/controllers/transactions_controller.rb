class TransactionsController < ApplicationController
    def show
        @ledger=Ledger.find(params[:id])
        @transactions=@ledger.transactions.all
    end
    def new
    end
    def create
    end
    def edit
    end
    def update
    end
    def destroy
    end
    private
    def transaction_params
        params.require(:transaction).permit(:amount,:sign,:description)
    end

end