# frozen_string_literal: true

class Transaction < ApplicationRecord
  enum status: %i[undetermined approved rejected]

  before_update :set_determination_time

  has_one_attached :document, dependent: :destroy
  belongs_to :ledger, touch: true

  validates :amount, presence: true
  validates :sign, exclusion: [nil]

  scope :find_created_by, ->(arg) { where('created_by= ? ', arg) }
  scope :filter_by_date, lambda { |arg|
                           where('created_at >= ?', arg[:criteria][1].to_datetime.beginning_of_day).where('created_at <= ?', arg[:criteria][3].to_datetime.end_of_day)
                         }
  scope :filter_by_date_and_ledger, ->(arg, arg1) { where(ledger_id: arg1).filter_by_date(arg) }
  scope :filter_by_date_and_ledger_and_user, lambda { |arg, arg1, arg2|
                                               find_created_by(arg2).filter_by_date_and_ledger(arg, arg1)
                                             }
  scope :calulate_sum, ->(arg) { where(sign: arg).where(status: %i[approved undetermined]).sum(:amount) }
  scope :report_sum, lambda { |arg, arg1|
                       where('EXTRACT(Year from created_at) = ?', arg1[:year]).where('EXTRACT(Month from created_at) = ?', arg1[:month]).calulate_sum(arg)
                     }
  scope :report_sum_by_user, lambda { |arg, arg1, arg2|
                               find_created_by(arg2).where('EXTRACT(Year from created_at) = ?', arg1[:year]).where('EXTRACT(Month from created_at) = ?', arg1[:month]).calulate_sum(arg)
                             }
  private

  def set_determination_time
    self.determined_at = Time.zone.now if determined_by.present?
  end
end
