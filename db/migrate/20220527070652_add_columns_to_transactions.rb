class AddColumnsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :created_by, :string
    add_column :transactions, :updated_by, :string
  end
end
