class Transaction < ApplicationRecord
    has_one_attached :document
    belongs_to :ledger
    validates :amount, presence: true
    validates :sign, exclusion: [nil]
end
