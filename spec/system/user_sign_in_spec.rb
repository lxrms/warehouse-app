require 'rails_helper'

describe 'User logs in' do
  it 'com sucesso' do
    # Arrange
    User.create! email: 'alex@gmail.com', password: '12345678'

    # Act
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'alex@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_content 'Olá, alex@gmail.com'
  end
end