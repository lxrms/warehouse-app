# frozen_string_literal: true

module Api
  module V1
    class WarehousesController < Api::V1::ApiController
      def index
        warehouses = Warehouse.all
        if warehouses.empty?
          render status: :ok, json: '[]'
        else
          render json: warehouses.as_json(except: %i[address created_at updated_at]), status: :ok
        end
      end

      def show
        @warehouse = Warehouse.find(params[:id])
      end

      def create
        warehouse_params = params.permit :name, :code, :description,
                                         :address, :city, :state,
                                         :postal_code, :total_area,
                                         :useful_area
        w = Warehouse.create warehouse_params
        if w.save
          render json: w, status: :created
        else
          render json: w.errors.full_messages, status: :unprocessable_entity
        end
      end
    end
  end
end
