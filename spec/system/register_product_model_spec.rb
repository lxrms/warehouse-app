require 'rails_helper'

describe 'Visitor register a product model' do
  it 'succesfully' do
    # Arrange
    Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                    cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                    email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
    Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                    cnpj: '61475820000124', address: 'Av. Brigadeiro, 100, São Paulo',
                    email: 'financeiro@lg.com.br', phone: '11 1234-5555'
    ProductCategory.create! name: 'Utensílios de Cozinha'
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')    
    
    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: '12'
    fill_in 'Largura', with:  '8'
    fill_in 'Profundidade', with: '14'
    select 'Utensílios de Cozinha', from: 'Categoria'
    fill_in 'SKU', with: 'CN2030140ABC'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Gravar'
      
    # Assert
    expect(page).to have_content 'Modelo de produto registrado com sucesso'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content '300 gramas'
    expect(page).to have_content 'Dimensões: 12 x 8 x 14'
    expect(page).to have_content 'SKU: CN2030140ABC'
    expect(page).to have_content 'Categoria: Utensílios de Cozinha'
    expect(page).to have_content 'Fornecedor: Samsung'

  end
end