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
      get "/api/v1/product_models/#{ pm.id }"
      
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json' 
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Caneca Legal'
    end
  end    
end
