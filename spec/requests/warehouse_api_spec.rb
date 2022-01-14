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
      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      expect(parsed_response).to eq []

    end

    
  end
end