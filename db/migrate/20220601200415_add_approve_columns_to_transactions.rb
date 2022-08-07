# frozen_string_literal: true

class AddApproveColumnsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :determination, :boolean
    add_column :transactions, :determined_by, :string
    add_column :transactions, :determined_at, :datetime
  end
end
