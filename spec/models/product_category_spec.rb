require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  it 'unique name' do
    # Arrange
    ProductCategory.create! name: 'Minha categoria'
    pc = ProductCategory.new name: 'Minha categoria'
    # Act
    result = pc.valid?
    # Assert
    expect(result).to eq false
  end
end
