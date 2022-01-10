require 'rails_helper'

describe 'User registers a bundle' do
  it 'successfully' do
    # Arrange
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    supplier = Supplier.create! fantasy_name: 'Geek&Stuff', legal_name: 'Geek&Stuff LTDA INC',
                                cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                                email: 'financeiro@ges.com.br', phone: '11 1234-5678'
    cat = ProductCategory.create! name: 'Utensílios de Cozinha'
    ProductModel.create! name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                         weight: '300', sku: 'CANSW12032103', supplier: supplier,
                         product_category: cat
    ProductModel.create! name: 'Copo Overwatch', height: '20', width: '12', length: '8',
                         weight: '200', sku: 'CPOOW12032103', supplier: supplier,
                         product_category: cat
    ProductModel.create! name: 'Lancheira', height: '20', width: '12', length: '8',
                         weight: '200', sku: 'LAOOW12032103', supplier: supplier,
                         product_category: cat
    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: 'Kit de copos'
    fill_in 'Código SKU', with: 'KIOOW12032103'
    check 'Caneca Star Wars'
    check 'Copo Overwatch'
    click_on 'Gravar'
    
    # Assert 
    expect(page).to have_content 'Kit de copos'
    expect(page).to have_content 'KIOOW12032103'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content 'CANSW12032103'
    expect(page).to have_content 'Copo Overwatch'
    expect(page).to have_content 'CPOOW12032103'
    expect(page).not_to have_content 'Lancheira'
    expect(page).not_to have_content 'LAOOW12032103'
  end
end