# frozen_string_literal: true

class CreateProductBundles < ActiveRecord::Migration[6.1]
  def change
    create_table :product_bundles do |t|
      t.string :name
      t.string :sku

      t.timestamps
    end
  end
end
