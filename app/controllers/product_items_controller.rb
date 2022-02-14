# frozen_string_literal: true

class ProductItemsController < ApplicationController
  def new_entry
    @product_models = ProductModel.all
    @warehouses = Warehouse.all
  end

  def process_entry
    product_model_id = params[:product_model_id]
    quantity = params[:quantity].to_i
    warehouse_id = params[:warehouse_id]

    pm = ProductModel.find(product_model_id)
    w = Warehouse.find(warehouse_id)

    quantity.times do
      ProductItem.create(warehouse: w, product_model: pm)
    end

    redirect_to w
  end
end
