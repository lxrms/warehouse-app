# frozen_string_literal: true

class CreateProductModels < ActiveRecord::Migration[6.1]
  def change
    create_table :product_models do |t|
      t.string :name
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :length
      t.string :sku
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
    add_index :product_models, :sku, unique: true

  end
end
