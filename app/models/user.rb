# frozen_string_literal: true

class User < ApplicationRecord
  has_many :ledgers, dependent: :destroy
  has_many :transactions, through: :ledgers, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :name, presence: true

  scope :find_name, ->(arg) { find(arg).name }
end
