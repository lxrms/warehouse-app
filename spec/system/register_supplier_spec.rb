# frozen_string_literal: true

require 'rails_helper'

describe 'User can register supplier' do
  it 'but visitor can\'t see link on menu' do
    # Arrange
    # Act
    visit root_path
    # Assert
    expect(page).not_to have_content 'Cadastrar novo fornecedor'
  end

  it 'but visitor can\'t access new_supplier directly' do
    # Arrange

    # Act
    visit new_supplier_path
    # Assert
    expect(current_path).not_to eq new_supplier_path
  end

  it 'successfully' do
    # Arrange
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: 'Toei'
    fill_in 'Razão Social', with: 'Toei ltda'
    fill_in 'CNPJ', with: '11111111111111'
    fill_in 'Endereço', with: 'Av das Laranjeiras, 744'
    fill_in 'E-mail', with: 'toei@gmail.com'
    fill_in 'Telefone', with: '11 11111-1111'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Fornecedor registrado com sucesso'
    expect(page).to have_content 'Razão Social: Toei ltda'
    expect(page).to have_content 'CNPJ: 11111111111111'
    expect(page).to have_content 'Endereço: Av das Laranjeiras, 744'
    expect(page).to have_content 'E-mail: toei@gmail.com'
    expect(page).to have_content 'Telefone: 11 11111-1111'
  end

  it 'but doesn\t fill the required fields' do
    # Arrange
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: 'Av das Laranjeiras, 744'
    fill_in 'E-mail', with: ''
    fill_in 'Telefone', with: '11 11111-1111'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Não foi possível registrar o fornecedor'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
  end
end
