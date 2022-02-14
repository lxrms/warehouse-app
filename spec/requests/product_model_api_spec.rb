# frozen_string_literal: true

require 'rails_helper'

describe 'Prodcut Model API' do
  context 'GET /api/v1/product_models/:id' do
    it 'successsfully' do
      # Arrange
      supplier = Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                                  cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                                  email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
      pc = ProductCategory.create! name: 'Eletronicos'
      pm = ProductModel.create! name: 'Caneca Legal', height: '14', width: '10',
                                length: '12', weight: '200', supplier: supplier,
                                product_category: pc

      # Act
      get "/api/v1/product_models/#{pm.id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['name']).to eq 'Caneca Legal'
    end

    it 'product model doesnt exist (status 404)' do
      # Arrange

      # Act
      get '/api/v1/product_models/99999999'

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Item não encontrado'
    end

    it 'invalid parameter (status 404)' do
      # get "/api/v1/product_models/loremipsum"
    end

    it 'database error (status 503)' do
      # Arrange
      supplier = Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                                  cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                                  email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
      pc = ProductCategory.create! name: 'Eletronicos'
      pm = ProductModel.create! name: 'Caneca Legal', height: '14', width: '10',
                                length: '12', weight: '200', supplier: supplier,
                                product_category: pc

      allow(ProductModel).to receive(:find)
        .with(pm.id.to_s)
        .and_raise ActiveRecord::ConnectionNotEstablished

      # Act
      get "/api/v1/product_models/#{pm.id}"

      # Assert
      expect(response.status).to eq 503
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Não foi possível conectar ao banco de dados'
    end

    it 'generic error (status 500)' do
      # Arrange
      supplier = Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                                  cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                                  email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
      pc = ProductCategory.create! name: 'Eletronicos'
      pm = ProductModel.create! name: 'Caneca Legal', height: '14', width: '10',
                                length: '12', weight: '200', supplier: supplier,
                                product_category: pc

      allow(ProductModel).to receive(:find)
        .with(pm.id.to_s)
        .and_raise ActiveRecord::ActiveRecordError

      # Act
      get "/api/v1/product_models/#{pm.id}"

      # Assert
      expect(response.status).to eq 500
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro no servidor'
    end
  end
end
