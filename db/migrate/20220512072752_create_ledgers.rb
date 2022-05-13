class CreateLedgers < ActiveRecord::Migration[7.0]
  def change
    create_table :ledgers do |t|

      t.belongs_to :user
      t.string :name, unique: true

      t.timestamps
    end
  end
end
