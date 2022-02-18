# frozen_string_literal: true

require 'rails_helper'

describe 'User gets to see all product models registered' do
  it 'successfully' do
    # Arrange
    s1 = Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                          cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                          email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    s2 = Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                          cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
                          email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    pc = ProductCategory.create! name: 'Utensílios de Cozinha'
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    pm1 = ProductModel.create!(name: 'Cadeira', weight: 500, height: 70, width: 80,
                               length: 120, supplier: s1, product_category: pc)
    pm2 = ProductModel.create!(name: 'Mesa baixa', weight: 300, height: 20, width: 80,
                               length: 120, supplier: s2, product_category: pc)

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver modelos de produtos'

    # Assert
    within("tr#product#{pm1.id}") do
      expect(page).to have_content 'Cadeira'
      expect(page).to have_content pm1.sku
      expect(page).to have_content 'Samsung'
      expect(page).to have_content 'Utensílios de Cozinha'
    end
    within("tr#product#{pm2.id}") do
      expect(page).to have_content 'Mesa baixa'
      expect(page).to have_content pm2.sku
      expect(page).to have_content 'LG'
      expect(page).to have_content 'Utensílios de Cozinha'
    end
  end

  it 'but it is empty' do
    # Arrange
    Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                     cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                     email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                     cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
                     email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    ProductCategory.create! name: 'Utensílios de Cozinha'
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver modelos de produtos'

    # Assert
    expect(page).to have_css 'h3', text: '(nenhum modelo de produto cadastrado)'
  end
end
