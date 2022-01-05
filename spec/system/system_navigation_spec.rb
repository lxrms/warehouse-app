require 'rails_helper'

describe 'Visitor navigates' do 
  it 'using menu' do 
    visit root_path
    within('nav') do
      expect(page).to have_link 'Início', href: root_path
      expect(page).to have_link 'Cadastrar novo galpão', href: new_warehouse_path
    end
  end
end