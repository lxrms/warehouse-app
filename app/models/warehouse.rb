class Warehouse < ApplicationRecord
  validates :name, :code, :description, :address,
            :city, :state, :postal_code,
            :total_area, :useful_area,
            presence: true
  validates :code, uniqueness: true
  validates :postal_code, format: { with: /\A\d{5}-\d{3}\z/ }
  
end
