class Transaction < ApplicationRecord
    has_one_attached :document
    belongs_to :ledger
    validates :amount, presence: true
    validates :sign, exclusion: [nil]

    scope :filter_by_date,->(arg) {where("created_at >= ?",arg[:criteria][1].to_datetime.beginning_of_day).where("created_at <= ?",arg[:criteria][3].to_datetime.end_of_day)}
    scope :filter_by_date_and_ledger,->(arg,arg1) {where(ledger_id:arg1).filter_by_date(arg)}
    scope :filter_by_date_and_ledger_and_user,->(arg,arg1,arg2) {where("created_by=?",arg2).filter_by_date_and_ledger(arg,arg1)}
end
