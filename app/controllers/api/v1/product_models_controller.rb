class Api::V1::ProductModelsController < Api::V1::ApiController
  def show
    pm = ProductModel.find(params[:id])
    render json: pm.as_json(
      except: [:created_at, :updated_at],
      methods: [:dimensions],
      include: [:supplier]),
      status: 200
  end


end