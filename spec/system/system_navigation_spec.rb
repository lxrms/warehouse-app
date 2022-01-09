require 'rails_helper'

describe 'Visitor navigates' do 
  it 'using menu' do 

    user = User.create! email: 'alex@gmail.com', password: '12345678'
    login_as user

    visit root_path

    within('nav') do
      expect(page).to have_link 'Início', href: root_path
      expect(page).to have_link 'Cadastrar novo galpão', href: new_warehouse_path
    end
  end
end