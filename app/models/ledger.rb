# frozen_string_literal: true

class Ledger < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  scope :find_name, ->(arg) { find(arg).name }
end
