# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor opens homepage' do
  it 'and sees a welcome message' do
    visit root_path
    expect(page).to have_css 'h1', text: 'Galpões Cadastrados'
  end

  it 'and sees registered warehouses' do
    # Arrange
    Warehouse.create! name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                      address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                      postal_code: '01010-010', total_area: '10000', useful_area: '8000'
    Warehouse.create! name: 'Porto Alegre 2', code: 'POA', description: 'Galpao medio',
                      address: 'Av Sapopemba', city: 'Porto Alegre', state: 'RS',
                      postal_code: '05010-010', total_area: '8000', useful_area: '7500'

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Galpões Cadastrados'
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Porto Alegre'
    expect(page).to have_content 'POA'

    expect(page).not_to have_content '(nenhum galpão encontrado)'
  end

  it 'and there aren\'t registered warehouses' do
    # Arrange
    # Act
    visit root_path

    # Assert
    expect(page).to have_content '(nenhum galpão encontrado)'
  end

  it 'doesnt show details of the registered warehouses' do
    # Arrange
    Warehouse.create! name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                      address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
                      postal_code: '57050-000', total_area: 10_000, useful_area: 8000

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

  it 'and they can search for warehouses' do
    # Arrange
    Warehouse.create! name: 'Guarulhos', code: 'GRU', description: 'Galpao grande',
                      address: 'Av do Estado', city: 'Guarulhos', state: 'SP',
                      postal_code: '01010-010', total_area: '10000', useful_area: '8000'
    Warehouse.create! name: 'Porto Alegre 2', code: 'POA', description: 'Galpao medio',
                      address: 'Av Sapopemba', city: 'Porto Alegre', state: 'RS',
                      postal_code: '05010-010', total_area: '8000', useful_area: '7500'

    # Act
    visit root_path
    fill_in 'search', with: 'legr'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content 'Galpões Cadastrados'
    expect(page).to have_content 'Porto Alegre'
    expect(page).to have_content 'POA'
    expect(page).not_to have_content 'Guarulhos'
    expect(page).not_to have_content 'GRU'

    expect(page).not_to have_content '(nenhum galpão encontrado)'
  end
end
