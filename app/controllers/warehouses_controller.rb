class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      flash[:notice] = 'Galpão registrado com sucesso'
      redirect_to @warehouse
    else
      flash.now[:alert] = 'Não foi possível registrar o galpão'
      render 'new'
    end
  end

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])
    if @warehouse.update(warehouse_params)
      flash[:notice] = 'Galpão editado com sucesso'
      redirect_to @warehouse
    else
      flash[:alert] = 'Não foi possível editar o galpão'
      render 'edit'
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :description,
                                      :address, :city, :state,
                                      :postal_code, :total_area,
                                      :useful_area)
  end
end