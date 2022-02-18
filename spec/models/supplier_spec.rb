# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Supplier, type: :model do
  it 'CNPJ must be unique' do
    # Arrange
    Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                     cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                     email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    supplier2 = Supplier.new fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                             cnpj: '71348822000106', address: 'Av. Brigadeiro, 100, São Paulo',
                             email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    # Act
    result = supplier2.valid?
    # Assert
    expect(result).to eq false
  end

  it 'CNPJ must have 14 digits' do
    # Arrange
    supplier1 = Supplier.new fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                             cnpj: '713488220001056', address: 'Av. Industrial, 1000, São Paulo',
                             email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    supplier2 = Supplier.new fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                             cnpj: '7134882200016', address: 'Av. Brigadeiro, 100, São Paulo',
                             email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    # Act
    result1 = supplier1.valid?
    result2 = supplier2.valid?
    # Assert
    expect(result1).to eq false
    expect(result2).to eq false
  end

  it 'Fantasy name is required' do
    # Arrange
    supplier = Supplier.new fantasy_name: '', legal_name: 'Samsung do Brasil Ltda',
                            cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                            email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    # Act
    result = supplier.valid?
    # Assert
    expect(result).to eq false
  end

  it 'Legal name is required' do
    # Arrange
    supplier = Supplier.new fantasy_name: 'Samsung', legal_name: '',
                            cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                            email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    # Act
    result = supplier.valid?
    # Assert
    expect(result).to eq false
  end

  it 'CNJ is required' do
    # Arrange
    supplier = Supplier.new fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                            cnpj: '', address: 'Av. Industrial, 1000, São Paulo',
                            email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    # Act
    result = supplier.valid?
    # Assert
    expect(result).to eq false
  end

  it 'Email is required' do
    # Arrange
    supplier = Supplier.new fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                            cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                            email: '', phone: '11 1234-5678'
    # Act
    result = supplier.valid?
    # Assert
    expect(result).to eq false
  end
end
