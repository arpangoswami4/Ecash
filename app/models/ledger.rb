class Ledger < ApplicationRecord
    belongs_to :users
    has_many :transactions, dependent: :destroy
    validates :name, presence: true, uniqueness: true
end
