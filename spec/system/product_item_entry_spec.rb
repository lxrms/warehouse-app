# frozen_string_literal: true

require 'rails_helper'

describe 'User enters new items' do
  it 'successfully' do
    # Arrange
    user = create(:user)
    warehouse = create(:warehouse, code: 'SCS', name: 'Maceió')
    s = create(:supplier)
    pc = create(:product_category)
    pm1 = create(:product_model, name: 'Caneca', supplier: s, product_category: pc)
    pm2 = create(:product_model, name: 'Pratos', supplier: s, product_category: pc)

    # Act
    login_as(user)
    visit root_path
    click_on 'Entrada de items'
    fill_in 'Quantidade', with: 100
    select 'SCS', from: 'Galpão de Destino'
    select 'Caneca', from: 'Produto'
    click_on 'Confirmar'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse)
    expect(page).to have_css 'h2', text: 'Estoque'
    within("div#product-#{pm1.id}") do
      expect(page).to have_content 'Caneca'
      expect(page).to have_content '100'
    end
  end

  it 'through the warehouse view' do
    # Arrange
    user = User.create(email: 'admin@email.com', password: '12345678')
    warehouse = Warehouse.create! name: 'São Caetano', code: 'SCS',
                                  address: 'Av Rio Branco', city: 'São Caetano',
                                  state: 'SP', postal_code: '36000-000',
                                  description: 'Um galpão de médio porte',
                                  total_area: '1000', useful_area: '800'
    s = Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                         cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
                         email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    pc = ProductCategory.create! name: 'Utensílios de Cozinha'
    pm1 = ProductModel.create! name: 'Caneca', height: '14', width: '10',
                               length: '12', weight: '200', supplier: s,
                               product_category: pc
    pm2 = ProductModel.create! name: 'Travesseiro', height: '124', width: '102',
                               length: '122', weight: '2002', supplier: s,
                               product_category: pc

    # Act
    login_as(user)
    visit root_path
    click_on 'São Caetano'

    fill_in 'Quantidade', with: 2
    select 'Caneca', from: 'Produto'
    click_on 'Confirmar'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse)
    expect(page).to have_css 'h2', text: 'Estoque'
    within("div#product-#{pm1.id}") do
      expect(page).to have_content 'Caneca'
      expect(page).to have_content 'Quantidade: 2'
    end
  end
end
