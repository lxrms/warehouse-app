class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse = Warehouse.new(warehouse_params)
    if warehouse.save
      redirect_to warehouse, notice: 'Galpão registrado com sucesso'
    else
      render :new
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