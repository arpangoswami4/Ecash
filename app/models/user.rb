# frozen_string_literal: true

class User < ApplicationRecord
  has_many :ledgers, dependent: :destroy
  has_many :transactions, through: :ledgers, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :name, presence: true
  before_destroy :delete_references
  has_secure_password

  def delete_references
    #     Transaction.each do |t|
    #       if t.determined_by == self.id || t.updated_by == self.id
    #         t.destroy
    #       end
    #     end
    #     Ledger.each do |l|
    #       if l.updated_by == self.id
    #         l.destroy
    #       end
    #     end
  end

  scope :find_name, ->(arg) { find(arg).name }
end
