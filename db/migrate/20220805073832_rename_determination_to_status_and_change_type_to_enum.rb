# frozen_string_literal: true

class RenameDeterminationToStatusAndChangeTypeToEnum < ActiveRecord::Migration[7.0]
  def change
    rename_column :transactions, :determination, :status
    change_column :transactions, :status, :integer
  end
end
