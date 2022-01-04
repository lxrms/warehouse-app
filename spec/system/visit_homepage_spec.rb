require 'rails_helper'

describe 'Visitor opens homepage' do
  it 'and sees a welcome message' do
    visit root_path
    expect(page).to have_css 'h1', text: 'WareHouse App'
    expect(page).to have_css 'h3', text: 'Boas vindas ao sistema de gestão de estoques'
  end

  it 'and sees registered warehouses' do
    # Arrange
    Warehouse.new(name: 'Guarulhos', code: 'GRU').save
    Warehouse.new(name: 'Porto Alegre', code: 'POA').save
    Warehouse.new(name: 'São Luís', code: 'SLZ').save
    Warehouse.new(name: 'Vitória', code: 'VIX').save
    
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
end