class Transaction < ApplicationRecord
    belongs_to :ledgers
    validates :amount, presence: true
end
