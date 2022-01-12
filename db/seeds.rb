
user = User.create(email: 'admin@email.com', password: '12345678')
warehouse = Warehouse.create! name: 'São Caetano', code: 'SCS',
                              address: 'Av Rio Branco', city: 'São Caetano',
                              state: 'SP', postal_code: '36000-000',
                              description: 'Um galpão de médio porte',
                              total_area: '1000', useful_area: '800'
supplier1 = Supplier.create! fantasy_name: 'Samsung', legal_name: 'Samsung do Brasil Ltda',
                             cnpj: '71348822000106', address: 'Av. Industrial, 1000, São Paulo',
                             email: 'financeiro@samsung.com.br', phone: '11 1234-5678'
supplier2 = Supplier.create! fantasy_name: 'LG', legal_name: 'LG do Brasil Ltda',
                             cnpj: '71348822000108', address: 'Av. Brigadeiro, 100, São Paulo',
                             email: 'financeiro@lg.com.br', phone: '11 1234-5555'
pc = ProductCategory.create! name: 'Eletronicos'
pm1 = ProductModel.create! name: 'Caneca', height: '14', width: '10',
                           length: '12', weight: '200', supplier: supplier1,
                           product_category: pc 
pm2 = ProductModel.create! name: 'Travesseiro', height: '124', width: '102',
                           length: '122', weight: '2002', supplier: supplier2,
                           product_category: pc
