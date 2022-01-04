require 'rails_helper'

describe 'Visitor opens homepage' do
  it 'and sees a welcome message' do
    visit root_path
    expect(page).to have_css 'h1', text: 'WareHouse App'
    expect(page).to have_css 'h3', text: 'Boas vindas ao sistema de gestão de estoques'
  end

  it 'and sees registered warehouses' do
    # Arrange
    Warehouse.create name: 'Guarulhos', code: 'GRU'
    Warehouse.create name: 'Porto Alegre', code: 'POA'
    Warehouse.create name: 'São Luís', code: 'SLZ'
    Warehouse.create name: 'Vitória', code: 'VIX'
    
    # Act
    visit root_path
    
    # Assert
    expect(page).to have_content 'Galpões Cadastrados'
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Porto Alegre'
    expect(page).to have_content 'POA'
    expect(page).to have_content 'São Luís'
    expect(page).to have_content 'SLZ'
    expect(page).to have_content 'Vitória'
    expect(page).to have_content 'VIX'

  end

  it 'and there aren\'t registered warehouses' do
  end
end