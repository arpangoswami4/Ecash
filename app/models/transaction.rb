class Transaction < ApplicationRecord
    has_one_attached :document
    belongs_to :ledger
    validates :amount, presence: true
    validates :sign, exclusion: [nil]

    scope :find_created_by,-> (arg) {where("created_by= ? ",arg)}
    scope :filter_by_date,->(arg) {where("created_at >= ?",arg[:criteria][1].to_datetime.beginning_of_day).where("created_at <= ?",arg[:criteria][3].to_datetime.end_of_day)}
    scope :filter_by_date_and_ledger,->(arg,arg1) {where(ledger_id:arg1).filter_by_date(arg)}
    scope :filter_by_date_and_ledger_and_user,->(arg,arg1,arg2) {find_created_by(arg2).filter_by_date_and_ledger(arg,arg1)}
    scope :calulate_sum,-> (arg) { where(sign:arg).where(determination:[true,nil]).sum(:amount)}
    scope :report_sum,->(arg,arg1) {where("EXTRACT(Year from created_at) = ?",arg1[:year]).where("EXTRACT(Month from created_at) = ?",arg1[:month]).calulate_sum(arg)}
    scope :report_sum_by_user,->(arg,arg1,arg2) {find_created_by(arg2).where("EXTRACT(Year from created_at) = ?",arg1[:year]).where("EXTRACT(Month from created_at) = ?",arg1[:month]).calulate_sum(arg)}
    
end
