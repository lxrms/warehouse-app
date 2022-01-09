require 'rails_helper'

describe 'User logs in' do
  it 'successfully' do
    # Arrange
    User.create! email: 'alex@gmail.com', password: '12345678'

    # Act
    visit root_path
    click_on 'Login'
    fill_in 'E-mail', with: 'alex@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_content 'Olá, alex@gmail.com'
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'and logs out' do
    # Arrange
    User.create! email: 'alex@gmail.com', password: '12345678'

    # Act
    visit root_path
    click_on 'Login'
    fill_in 'E-mail', with: 'alex@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Sair'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_link 'Login'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_content 'Olá, alex@gmail.com'
    expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end