# frozen_string_literal: true

class ProductBundlesController < ApplicationController
  def new
    @product_bundle = ProductBundle.new
    @product_models = ProductModel.all
  end

  def create
    bundle_params = params.require(:product_bundle).permit(:name, :sku, product_model_ids: [])
    @product_bundle = ProductBundle.new bundle_params
    @product_bundle.save
    redirect_to @product_bundle
  end

  def show
    @product_bundle = ProductBundle.find(params[:id])
  end
end
