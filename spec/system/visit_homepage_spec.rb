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

    expect(page).not_to have_content '(não há galpões cadastrados)'
  end

  it 'and there aren\'t registered warehouses' do
    # Arrange
    # Act
    visit root_path

    # Assert
    expect(page).to have_content '(não há galpões cadastrados)'
  end

  it 'doesnt show details of the registered warehouses' do
    # Arrange
    Warehouse.create name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
    address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
    postal_code: '57050-000', total_area: 10000, useful_area: 8000

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_content 'Ótimo galpão numa linda cidade'
    expect(page).not_to have_content 'Av. Fernandes Lima'
    expect(page).not_to have_content 'Maceió/AL'
    expect(page).not_to have_content 'CEP: 57050-000'
    expect(page).not_to have_content 'Área Total: 10000 m²'
    expect(page).not_to have_content 'Área Útil: 8000 m²'
  end
end