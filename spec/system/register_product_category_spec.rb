# frozen_string_literal: true

require 'rails_helper'

describe 'User can add a product category' do
  it 'successfullly' do
    # Arrange
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar categoria de produto'
    fill_in 'Nome', with: 'Minha categoria'
    click_on 'Gravar'
    # Assert
    result = ProductCategory.find_by(name: 'Minha categoria')
    expect(result).not_to eq nil
  end

  it 'but the required fields are empty' do
    # Arrange
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar categoria de produto'
    fill_in 'Nome', with: ''
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Nome não pode ficar em branco'
  end

  it 'but the name is duplicated' do
    # Arrange
    ProductCategory.create! name: 'Minha categoria'
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar categoria de produto'
    fill_in 'Nome', with: 'Minha categoria'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Nome já está em uso'
  end

  it 'only if logged in (directly)' do
    # Arrange
    # Act
    visit new_product_category_path
    # Assert
    expect(current_path).not_to eq new_product_category_path
  end

  it 'only if logged in (through the navigation bar)' do
    # Arrange
    # Act
    visit root_path
    # Assert
    expect(page).not_to have_content 'Cadastrar categoria de produto'
  end
end
