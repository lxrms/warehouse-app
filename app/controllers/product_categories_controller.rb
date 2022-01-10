class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]


  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      flash[:notice] = 'Categoria de produto registrada com sucesso'
      redirect_to root_path
    else
      flash[:alert] = 'Nao foi possível registrar a categoria de produto'
      render 'new'
    end
  end

  private

  def product_category_params
    params.require(:product_category).permit(:name)  
  end
end