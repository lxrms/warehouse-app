FactoryBot.define do
  factory :supplier do
    fantasy_name { 'LG' }
    legal_name { 'LG do Brasil Ltda' }
    cnpj { '61475820000124' }
    address { 'Av. Brigadeiro, 100, São Paulo' }
    email { 'financeiro@lg.com.br' }
    phone { '11 1234-5555' }
  end
end
