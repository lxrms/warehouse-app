# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      rescue_from ActiveRecord::ActiveRecordError, with: :return_default
      rescue_from ActiveRecord::RecordNotFound, with: :return_404
      rescue_from ActiveRecord::ConnectionNotEstablished, with: :return_503

      private

      def return_404
        render status: :not_found, json: { "error": 'Item não encontrado' }
      end

      def return_503
        render status: :service_unavailable, json: { "error": 'Não foi possível conectar ao banco de dados' }
      end

      def return_default
        render status: :internal_server_error, json: { "error": 'Erro no servidor' }
      end
    end
  end
end
