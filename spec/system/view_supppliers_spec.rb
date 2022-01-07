require 'rails_helper'

describe 'Visitor sees suppliers' do
  it 'from homepage' do
    # Arrange
    # Act
    visit root_path

    # Assert
    expect(page).to have_link 'Ver Fornecedores', href: suppliers_path
  end

  it 'previously registered' do
    # Arrange
    Supplier.create fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                             cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                             email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    Supplier.create fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                             cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
                             email: 'financeiro@lg.com.br', phone: '11 1234-5555'

    # Act
    visit root_path
    click_on 'Ver Fornecedores'

    # Assert
    expect(page).to have_content 'Samsung'
    expect(page).to have_content '71348822000106'
    expect(page).to have_content 'LG'
    expect(page).to have_content '61475820000124'
    expect(page).not_to have_content '(não há fornecedores cadastrados)'

  end

  it 'and there arent suppliers' do
    # Arrange
    # Act
    visit root_path
    click_on 'Ver Fornecedores'
  
    # Assert
    expect(page).to have_content '(não há fornecedores cadastrados)'
  end
end