FactoryBot.define do
  factory :product_model do
    name { "Caneca" }
    height { "14" }
    width { "10" }
    length { "12" }
    weight { "200" }
    supplier
  end
end