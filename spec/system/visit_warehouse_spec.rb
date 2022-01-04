require 'rails_helper'

describe 'Visitor see a warehouse' do
  it 'and sees all the registered warehouses' do
    # Arrange
    Warehouse.create name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000', total_area: 10000, useful_area: 8000

    # Act
    visit root_path
    click_on 'Maceió'

    # Assert
    expect(page).to have_content 'Maceió'
    expect(page).to have_content 'MCZ'
    expect(page).to have_content 'Ótimo galpão numa linda cidade'
    expect(page).to have_content 'Av. Fernandes Lima'
    expect(page).to have_content 'Maceió/AL'
    expect(page).to have_content 'CEP: 57050-000'
    expect(page).to have_content 'Área Total: 10000 m²'
    expect(page).to have_content 'Área Útil: 8000 m²'
  end

  it 'and goes back to homepage' do
    # Arrange
    Warehouse.create name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000', total_area: 10000, useful_area: 8000

    # Act
    visit root_path
    click_on 'Maceió'
    click_on 'Voltar'
    
    # Assert
    expect(current_path).to eq root_path
  end

end