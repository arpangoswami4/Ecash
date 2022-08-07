# frozen_string_literal: true

class ChangeColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :determined_by, :bigint
    change_column :transactions, :created_by, :bigint
    change_column :transactions, :updated_by, :bigint
    change_column :ledgers, :created_by, :bigint
    change_column :ledgers, :updated_by, :bigint
  end
end
