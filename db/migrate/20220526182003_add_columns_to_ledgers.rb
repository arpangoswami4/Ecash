# frozen_string_literal: true

class AddColumnsToLedgers < ActiveRecord::Migration[7.0]
  def change
    add_column :ledgers, :created_by, :string
    add_column :ledgers, :updated_by, :string
  end
end
