class ProductModel < ApplicationRecord
  belongs_to :supplier 

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
