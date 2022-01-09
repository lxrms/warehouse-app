require 'rails_helper'

describe 'User registers a warehouse' do
  it 'and a visitor doesnt see the menu' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Cadastrar novo galpão'
  end

  it 'and can\'t access directly the form' do
    # Arrange
    # Act
    visit new_warehouse_path

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'through a link in homepage' do
    # Arrange
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    
    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar novo galpão'
    # Assert
    expect(page).to have_content 'Cadastrar novo galpão'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Área Total'
    expect(page).to have_field 'Área Útil'
    expect(page).to have_button 'Gravar'
  end

  it 'successfully' do
    # Arrange
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    
    # Act
    login_as(user, :scope => :user)
    visit root_path
    
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Descrição', with: 'Um galpão mineiro com o pé no Rio'
    fill_in 'Área Total', with: '5000'
    fill_in 'Área Útil', with: '3000'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Juiz de Fora'
    expect(page).to have_content 'JDF'
    expect(page).to have_content 'Um galpão mineiro com o pé no Rio'
    expect(page).to have_content 'Av Rio Branco'
    expect(page).to have_content 'Juiz de Fora/MG'
    expect(page).to have_content 'CEP: 36000-000'
    expect(page).to have_content 'Área Total: 5000 m²'
    expect(page).to have_content 'Área Útil: 3000 m²'
    expect(page).to have_content 'Galpão registrado com sucesso'

  end

  it 'and all the fields are required with error messages' do
    # Arrange
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    
    # Act
    login_as(user, :scope => :user)
    visit root_path

    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Área Total', with: ''
    fill_in 'Área Útil', with: ''
    click_on 'Gravar'

    # Assert
    expect(page).not_to have_content 'Galpão registrado com sucesso'
    expect(page).to have_content 'Não foi possível registrar o galpão'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Área Total não pode ficar em branco'
    expect(page).to have_content 'Área Útil não pode ficar em branco'
  end
end