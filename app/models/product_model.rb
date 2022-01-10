class ProductModel < ApplicationRecord
  belongs_to :supplier 
  belongs_to :product_category 
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items

  # before_create :generate_sku

  def dimensions
    "#{height} x #{width} x #{length}"
  end

  private
  
  # def generate_sku
  #   new_sku = SecureRandom.hex(14).upcase
  #   until ProductModel.find_by(sku: new_sku).nil? do
  #     new_sku = SecureRandom.hex(14).upcase
  #   end
  #   self.sku = new_sku
  # end
end
