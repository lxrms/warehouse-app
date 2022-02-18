# frozen_string_literal: true

class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_default
  rescue_from ActiveRecord::RecordNotFound, with: :return_not_found
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :return_db_error

  private

  def return_not_found
    render status: 404, json: { error: 'Item não encontrado' }
  end

  def return_db_error
    render status: 503, json: { error: 'Não foi possível conectar ao banco de dados' }
  end

  def return_default
    render status: 500, json: { error: 'Erro no servidor' }
  end
end
