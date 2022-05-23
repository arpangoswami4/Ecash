class Transaction < ApplicationRecord
    belongs_to :ledger
    validates :amount, presence: true
end
