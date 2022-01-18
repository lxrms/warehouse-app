class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_default
  rescue_from ActiveRecord::RecordNotFound, with: :return_404
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :return_503

  private
  
  def return_404
    render status: 404, json: { "error": "Item não encontrado"}
  end

  def return_503
    render status: 503, json: { "error": "Não foi possível conectar ao banco de dados"}
  end

  def return_default
    render status: 500, json: { "error": "Erro no servidor"}
  end
end