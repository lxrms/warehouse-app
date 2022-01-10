class ProductModelsController < ApplicationController
  def show
    @product_model = ProductModel.find(params[:id])

  end
  
  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
    @product_categories = ProductCategory.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      flash[:notice] = 'Modelo de produto registrado com sucesso'
      redirect_to @product_model
    else
      flash.now[:alert] = 'Não foi possível registrar o modelo de produto'
      render 'new'
    end
  end

  private

  def product_model_params
    params.require(:product_model).permit :name, :weight,
                                          :height, :width, :length,
                                          :sku, :supplier_id, :product_category_id
  end
end