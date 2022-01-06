require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  it 'Does not allow duplicated codes' do
    # Arrange
    warehouse = Warehouse.create name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                 address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                 postal_code: '01010-010', total_area: '10000', useful_area: '8000'
    warehouse2 = Warehouse.new  name: 'Porto Alegre 2', code: 'GRU', description: 'Galpao medio',
                                address: 'Av Sapopemba', city: 'Porto Alegre', state: 'RS',
                                postal_code: '05010-010', total_area: '8000', useful_area: '7500'
    # Act
    result = warehouse2.valid?
    # Assert
    expect(result).to eq false
  end

  context 'Postal code only accepts the format ddddd-ddd' do
    it 'Format 01010010' do
      #Arrange
      warehouse = Warehouse.new name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                postal_code: '01010010', total_area: '10000', useful_area: '8000'
      # Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end

    it 'Format 001010-010' do
      #Arrange
      warehouse = Warehouse.new name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                postal_code: '001010-010', total_area: '10000', useful_area: '8000'
      # Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end

    it 'Format 01010-0010' do
      #Arrange
      warehouse = Warehouse.new name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                postal_code: '01010-0010', total_area: '10000', useful_area: '8000'
      # Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end

    it 'Format aaaaa-aaa' do
      #Arrange
      warehouse = Warehouse.new name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                postal_code: 'aaaaa-aaa', total_area: '10000', useful_area: '8000'
      # Act
      result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end
  end

  it 'Name is required' do
    # Arrange
    warehouse = Warehouse.create name: '', code: 'GRU', description: 'Galpao grande',
                                 address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                 postal_code: '01010-010', total_area: '10000', useful_area: '8000'
    # Act
    result = warehouse.valid?
    # Assert
    expect(result).to eq false
  end

  it 'Code is required' do
    # Arrange
    warehouse = Warehouse.create name: 'Guarulhos', code: '', description: 'Galpao grande',
                                 address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                 postal_code: '01010-010', total_area: '10000', useful_area: '8000'
    # Act
    result = warehouse.valid?
    # Assert
    expect(result).to eq false
  end

  it 'Description is required' do
    # Arrange
    warehouse = Warehouse.create name: 'Guarulhos', code: 'GRU', description: '',
                                 address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                 postal_code: '01010-010', total_area: '10000', useful_area: '8000'
    # Act
    result = warehouse.valid?
    # Assert
    expect(result).to eq false
  end

  it 'Address is required' do
    # Arrange
    warehouse = Warehouse.create name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                 address: '', city: 'Guarulhos', state: 'SP',
                                 postal_code: '01010-010', total_area: '10000', useful_area: '8000'
    # Act
    result = warehouse.valid?
    # Assert
    expect(result).to eq false
  end

  it 'City is required' do
    # Arrange
    warehouse = Warehouse.create name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                 address: 'Av do Estado', city: '', state: 'SP',
                                 postal_code: '01010-010', total_area: '10000', useful_area: '8000'
    # Act
    result = warehouse.valid?
    # Assert
    expect(result).to eq false
  end

  it 'State is required' do
    # Arrange
    warehouse = Warehouse.create name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                 address: 'Av do Estado', city: 'Guarulhos', state: '',
                                 postal_code: '01010-010', total_area: '10000', useful_area: '8000'
    # Act
    result = warehouse.valid?
    # Assert
    expect(result).to eq false
  end

  it 'Postal code is required' do
    # Arrange
    warehouse = Warehouse.create name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                 address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                 postal_code: '', total_area: '10000', useful_area: '8000'
    # Act
    result = warehouse.valid?
    # Assert
    expect(result).to eq false
  end

  it 'Total area is required' do
    # Arrange
    warehouse = Warehouse.create name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                 address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                 postal_code: '01010-010', total_area: '', useful_area: '8000'
    # Act
    result = warehouse.valid?
    # Assert
    expect(result).to eq false
  end

  it 'Usefull area is required' do
    # Arrange
    warehouse = Warehouse.create name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                                 address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                                 postal_code: '01010-010', total_area: '10000', useful_area: ''
    # Act
    result = warehouse.valid?
    # Assert
    expect(result).to eq false
  end
end
