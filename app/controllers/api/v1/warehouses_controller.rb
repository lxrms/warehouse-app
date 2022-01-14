class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    if warehouses.empty?
      render status: 200, json: '[]'
    else
      render json: warehouses.as_json(except: [:address, :created_at, :updated_at]), status: 200
    end
  end
end