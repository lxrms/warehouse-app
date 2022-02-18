# frozen_string_literal: true

class CreateWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    add_index :warehouses, :code, unique: true

  end
end
