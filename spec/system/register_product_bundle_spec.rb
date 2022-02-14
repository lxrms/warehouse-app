# frozen_string_literal: true

require 'rails_helper'

describe 'User registers a bundle' do
  it 'successfully' do
    # Arrange
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    supplier = Supplier.create! fantasy_name: 'Geek&Stuff', legal_name: 'Geek&Stuff LTDA INC',
                                cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                                email: 'financeiro@ges.com.br', phone: '11 1234-5678'
    cat = ProductCategory.create! name: 'Utensílios de Cozinha'
    p1 = ProductModel.create! name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                              weight: '300', supplier: supplier,
                              product_category: cat
    p2 = ProductModel.create! name: 'Copo Overwatch', height: '20', width: '12', length: '8',
                              weight: '200', supplier: supplier,
                              product_category: cat
    p3 = ProductModel.create! name: 'Lancheira', height: '20', width: '12', length: '8',
                              weight: '200', supplier: supplier,
                              product_category: cat
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: 'Kit de copos'
    check 'Caneca Star Wars'
    check 'Copo Overwatch'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Kit de copos'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content p1.sku
    expect(page).to have_content 'Copo Overwatch'
    expect(page).to have_content p2.sku
    expect(page).not_to have_content 'Lancheira'
    expect(page).not_to have_content p3.sku
  end
end
