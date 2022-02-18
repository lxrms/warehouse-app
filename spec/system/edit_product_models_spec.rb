# frozen_string_literal: true

require 'rails_helper'

describe 'User gets to see all product models registered' do
  it 'successfully' do
    # Arrange
    s1 = Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                          cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                          email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                     cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
                     email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    pc = ProductCategory.create! name: 'Utensílios de Cozinha'
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    pm1 = ProductModel.create!(name: 'Cadeira', weight: 500, height: 70, width: 80,
                               length: 120, supplier: s1, product_category: pc)
    init_sku = pm1.sku

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver modelos de produtos'
    within("tr#product#{pm1.id}") do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'Cadeira bonita'
    fill_in 'Peso', with: 600
    fill_in 'Altura', with: '80'
    fill_in 'Largura', with: '90'
    fill_in 'Profundidade', with: '130'
    select 'Utensílios de Cozinha', from: 'Categoria'
    select 'LG', from: 'Fornecedor'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Cadeira bonita'
    expect(page).to have_content init_sku
    expect(page).to have_content 'LG'
    expect(page).to have_content 'Utensílios de Cozinha'
  end
end
