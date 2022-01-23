FactoryBot.define do
  factory :warehouse do
    name { "Santos" }
    code { "SNS" }
    address { "Rua Bertioga" }
    city { "Santos" }
    state { "SP" }
    postal_code { "01020-030" }
    description { "Galpa enferrujado" }
    total_area { "23_000" }
    useful_area { "21_000" }
  end
end

