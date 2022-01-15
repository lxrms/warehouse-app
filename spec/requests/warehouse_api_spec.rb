require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do 
    it 'successfully' do
      # Arrange
      Warehouse.create! name: 'São Caetano', code: 'SCS',
                        address: 'Av Rio Branco', city: 'São Caetano',
                        state: 'SP', postal_code: '36000-000',
                        description: 'Um galpão de médio porte',
                        total_area: '1000', useful_area: '800'

      Warehouse.create! name: 'Guarulhos', code: 'GRU',
                        address: 'Av Paes Lemes', city: 'São Caetano',
                        state: 'SP', postal_code: '36000-000',
                        description: 'Um galpão de médio porte',
                        total_area: '1000', useful_area: '800'
      
      # Act
      get '/api/v1/warehouses'
      
      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      expect(parsed_response[0]["name"]).to eq 'São Caetano'
      expect(response.body).not_to include 'Av Rio Branco'
      expect(response.body).not_to include 'Av Paes Lemes'
    end

    it 'and is empty' do
      # Arrange
      # Act 
      get '/api/v1/warehouses'
      
      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/warehouse/:id' do
    it 'successfully' do
      # Arrange
      w = Warehouse.create! name: 'Guarulhos', code: 'GRU',
                            address: 'Av Paes Lemes', city: 'São Caetano',
                            state: 'SP', postal_code: '36000-000',
                            description: 'Um galpão de médio porte',
                            total_area: '1000', useful_area: '800'
      # Act
      get "/api/v1/warehouses/#{w.id}"
      # Assert
      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body)
      expect(response.content_type).to include 'application/json'
      expect(parsed_response["name"]).to eq 'Guarulhos'
      expect(parsed_response["code"]).to eq 'GRU'
      expect(parsed_response["postal_code"]).to eq '36000-000'
      expect(parsed_response.keys).not_to include "created_at"
      expect(parsed_response.keys).not_to include "updated_at"
    end

    it 'warehouse doesnt exist' do
      # Arrange
      # Act
      get "/api/v1/warehouses/999"

      # Assert
      expect(response.status).to eq 404
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'successfully' do
      # Arrange
      # Act
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/warehouses', params: '
                                   {
                                     "name": "Maceió",
                                     "code": "MCZ",
                                     "description": "Ótimo galpão numa linda cidade",
                                     "address": "Avenida dos Galpões, 1000",
                                     "city": "Maceió",
                                     "state": "AL",
                                     "postal_code": "57050-000",
                                     "total_area": 10000,
                                     "useful_area": 8000
                                   }',
                                 headers: headers 
      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
      expect(parsed_response["code"]).to eq 'MCZ'
      expect(parsed_response["name"]).to eq 'Maceió'
    end

    it 'has required fields' do
      # Arrange
      # Act
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/warehouses', params: '
                                   {
                                     "city": "Maceió",
                                     "state": "AL",
                                     "postal_code": "57050-000",
                                     "total_area": 10000,
                                     "useful_area": 8000
                                   }',
                                 headers: headers 
      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
      expect(response.body).to include 'Código não pode ficar em branco'
      expect(response.body).to include 'Descrição não pode ficar em branco'
      expect(response.body).to include 'Endereço não pode ficar em branco'
    end

    it 'code is no unique' do
    end
  end
end