require 'rails_helper'

describe 'Warehouse API' do
  it 'GET /warehouse' do
    # Arrange
    Warehouse.create! name: 'São Caetano', code: 'SCS',
                      address: 'Av Rio Branco', city: 'São Caetano',
                      state: 'SP', postal_code: '36000-000',
                      description: 'Um galpão de médio porte',
                      total_area: '1000', useful_area: '800'

    Warehouse.create! name: 'Guarulhos', code: 'GRU',
                      address: 'Av Rio Branco', city: 'São Caetano',
                      state: 'SP', postal_code: '36000-000',
                      description: 'Um galpão de médio porte',
                      total_area: '1000', useful_area: '800'
    
    # Act
    get '/api/warehouses'

    # Assert
    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    expect(response.body).to include 'São Caetano'
    expect(response.body).to include 'Guarulhos'
  end
end