require 'rails_helper'

describe 'Visitor see a warehouse' do
  it 'and sees all the registered warehouses' do
    # Arrange
    Warehouse.create! name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
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
    Warehouse.create! name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000', total_area: 10000, useful_area: 8000

    # Act
    visit root_path
    click_on 'Maceió'
    click_on 'Voltar'
    
    # Assert
    expect(current_path).to eq root_path
  end

  it 'and sees the quantity of product items inside the warehouse' do
    # Arrange
    user = User.create(email: 'admin@email.com', password: '12345678')
    warehouse1 = Warehouse.create! name: 'São Caetano', code: 'SCS',
                                  address: 'Av Rio Branco', city: 'São Caetano',
                                  state: 'SP', postal_code: '36000-000',
                                  description: 'Um galpão de médio porte',
                                  total_area: '1000', useful_area: '800'
    warehouse2 = Warehouse.create! name: 'São José', code: 'SJS',
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
    100.times do
      ProductItem.create! warehouse: warehouse1, product_model: pm1
    end
    visit product_model_path(warehouse1)

    # Assert
    expect(page).to have_content 'Galpão: São Caetano'
    expect(page).to have_content 'Quantidade: 100'
    expect(page).not_to have_content 'Galpão: São José'
        
  end
end