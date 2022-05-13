class Transaction < ApplicationRecord
    belongs_to :ledgers
    validates :amount, presence: true
    validates :sign, presence: true
end
