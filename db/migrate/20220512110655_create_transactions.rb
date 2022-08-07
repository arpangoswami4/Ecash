# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :ledger
      t.integer :amount
      t.text :description
      t.boolean :sign

      t.timestamps
    end
  end
end
