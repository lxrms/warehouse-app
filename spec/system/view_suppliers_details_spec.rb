require 'rails_helper'

describe 'Visitor sees supplier details' do
  it 'successfully' do
    # Arrange
    Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
      cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
      email: 'financeiro@samsung.com.br', phone: '11 1234-5678'

    # Act
    visit root_path
    click_on 'Ver Fornecedores'
    click_on 'Samsung'

    # Assert
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Razão Social: Samsung do Brasil Ltda'
    expect(page).to have_content 'CNPJ: 71348822000106'
    expect(page).to have_content 'Endereço: Av. Industrial, 1000, São Paulo'
    expect(page).to have_content 'E-mail: financeiro@samsung.com.br'
  end

  it 'and sees supllier\'s products' do
    # Arrange
    supplier = Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                        cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                        email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    ProductModel.create! name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                        weight: '300', sku: 'CANSW12032103', supplier: supplier
    ProductModel.create! name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                        weight: '400', sku: 'PLD9012839210', supplier: supplier

    # Act
    visit root_path
    click_on 'Ver Fornecedores'
    click_on 'Samsung'
    save_page

    # Assert
    expect(page).to have_css 'h1', text: 'Samsung'
    expect(page).to have_content 'Razão Social: Samsung do Brasil Ltda'
    expect(page).to have_content 'CNPJ: 71348822000106'
    expect(page).to have_content 'Endereço: Av. Industrial, 1000, São Paulo'
    expect(page).to have_content 'E-mail: financeiro@samsung.com.br'

    expect(page).to have_css 'h2', text: 'Produtos do fornecedor:'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content 'CANSW12032103'
    expect(page).to have_content 'Pelúcia Dumbo'
    expect(page).to have_content 'PLD9012839210'
  end
end