require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  it '.dimensions' do
    # Arrange
    p = ProductModel.new(height: '14', width: '10', length: '12')

    # Act
    result = p.dimensions

    # Assert
    expect(result).to eq '14 x 10 x 12'
  end

  it 'should generate SKU' do
    #Arrange 
    s = Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                         cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
                         email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    pc = ProductCategory.create! name: 'Utensílios de Cozinha'
    pm = ProductModel.create! name: 'Caneca', height: '14', width: '10',
                              length: '12', weight: '200', supplier: s,
                              product_category: pc 
    # Act
    pm.save
    # Assert
    expect(pm.sku).not_to eq nil
    expect(pm.sku.length).to eq 20
  end
end
