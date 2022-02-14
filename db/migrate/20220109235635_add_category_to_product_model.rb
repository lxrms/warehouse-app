# frozen_string_literal: true

class AddCategoryToProductModel < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_models, :product_category, null: false, foreign_key: true
  end
end
