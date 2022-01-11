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

  it 'should generate a random SKU' do
    # Arrange
    supplier = Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
      cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
      email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    product_category = ProductCategory.create! name: 'Utensílios de Cozinha'
    product_model = ProductModel.new name: 'Caneca', height: '14', width: '10',
                    length: '12', weight: '200', supplier: supplier,
                    product_category: product_category 
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return '6WS4S4S4S4S4S4S4S4S4'
    # Act
    product_model.save!
    # Assert
    expect(product_model.sku).to eq '6WS4S4S4S4S4S4S4S4S4'
  end

  it 'should not update the sku' do
    # Arrange
    supplier = Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
      cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
      email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    product_category = ProductCategory.create! name: 'Utensílios de Cozinha'
    product_model = ProductModel.new name: 'Caneca', height: '14', width: '10',
                    length: '12', weight: '200', supplier: supplier,
                    product_category: product_category 
    product_model.save
    sku = product_model.sku

    # Act
    product_model.update(name: 'Monitor Widescreen')

    # Assert
    expect(product_model.name).to eq 'Monitor Widescreen'
    expect(product_model.sku).to eq sku
  end

  it 'should generate unique sku' do
    # Arrange
    supplier = Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
      cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
      email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    product_category = ProductCategory.create! name: 'Utensílios de Cozinha'

    product_model1 = ProductModel.create! name: 'Caneca', height: '14', width: '10',
                                         length: '12', weight: '200', supplier: supplier,
                                         product_category: product_category 

    # Act
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return product_model1.sku
    product_model2 = ProductModel.create! name: 'Caneca', height: '14', width: '10',
                                          length: '12', weight: '200', supplier: supplier,
                                          product_category: product_category 

    result = product_model2.valid?
    # Assert
    expect(result).to eq false

    
  end
end
