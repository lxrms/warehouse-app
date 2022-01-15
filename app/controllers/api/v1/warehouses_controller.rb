class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    if warehouses.empty?
      render status: 200, json: '[]'
    else
      render json: warehouses.as_json(except: [:address, :created_at, :updated_at]), status: 200
    end
  end

  def show
    begin
      warehouse = Warehouse.find(params[:id])
      render json: warehouse.as_json(except: [:created_at, :updated_at]), status: 200
    rescue ActiveRecord::RecordNotFound
      render json: '{}', status: 404
    end
  end

  def create
    warehouse_params = params.permit :name, :code, :description,
                                     :address, :city, :state,
                                     :postal_code, :total_area,
                                     :useful_area
    w = Warehouse.create warehouse_params
    if w.save
      render json: w, status: 201
    else 
      render json: w.errors.full_messages, status: 422
    end

  end
end