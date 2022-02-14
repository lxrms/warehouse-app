# frozen_string_literal: true

module Api
  module V1
    class ProductModelsController < Api::V1::ApiController
      def show
        pm = ProductModel.find(params[:id])
        render json: pm.as_json(
          except: %i[created_at updated_at],
          methods: [:dimensions],
          include: [:supplier]
        ),
               status: :ok
      end
    end
  end
end
