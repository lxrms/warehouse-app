# frozen_string_literal: true

require 'rails_helper'

describe 'User edits a warehouse' do
  it 'but is not logged in' do
    # Arrange
    warehouse = Warehouse.create! name: 'São Caetano', code: 'SCS',
                                  address: 'Av Rio Branco', city: 'São Caetano',
                                  state: 'SP', postal_code: '36000-000',
                                  description: 'Um galpão de médio porte',
                                  total_area: '1000', useful_area: '800'
    # Act
    visit root_path
    click_on 'São Caetano'
    # Assert
    expect(page).not_to have_link 'Editar'
  end

  it 'directly but is not logged in' do
    # Arrange
    warehouse = Warehouse.create! name: 'São Caetano', code: 'SCS',
                                  address: 'Av Rio Branco', city: 'São Caetano',
                                  state: 'SP', postal_code: '36000-000',
                                  description: 'Um galpão de médio porte',
                                  total_area: '1000', useful_area: '800'
    # Act
    visit edit_warehouse_path(warehouse)
    # Assert
    expect(page).not_to eq edit_warehouse_path(warehouse)
  end

  it 'successfully' do
    # Arrange
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    warehouse = Warehouse.create! name: 'São Caetano', code: 'SCS',
                                  address: 'Av Rio Branco', city: 'São Caetano',
                                  state: 'SP', postal_code: '36000-000',
                                  description: 'Um galpão de médio porte',
                                  total_area: '1000', useful_area: '800'
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'São Caetano'
    click_on 'Editar'
    fill_in 'Nome', with: 'Juiz de Fora'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Galpão editado com sucesso'
    expect(page).to have_content 'Juiz de Fora'
    expect(page).to have_content 'SCS'
    expect(page).to have_content 'Av Rio Branco'
    expect(page).to have_content 'São Caetano'
    expect(page).to have_content 'SP'
    expect(page).to have_content '36000-000'
    expect(page).to have_content 'Um galpão de médio porte'
    expect(page).to have_content '1000'
    expect(page).to have_content '800'
  end

  it 'unsuccessfully' do
    # Arrange
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    warehouse = Warehouse.create! name: 'São Caetano', code: 'SCS',
                                  address: 'Av Rio Branco', city: 'São Caetano',
                                  state: 'SP', postal_code: '36000-000',
                                  description: 'Um galpão de médio porte',
                                  total_area: '1000', useful_area: '800'
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'São Caetano'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Área Total', with: ''
    fill_in 'Área Útil', with: ''
    click_on 'Gravar'

    # Assert
    expect(page).not_to have_content 'Galpão editado com sucesso'
    expect(page).to have_content 'Não foi possível editar o galpão'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Área Total não pode ficar em branco'
    expect(page).to have_content 'Área Útil não pode ficar em branco'
  end
end
