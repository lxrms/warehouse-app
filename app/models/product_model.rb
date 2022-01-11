class ProductModel < ApplicationRecord
  belongs_to :supplier 
  belongs_to :product_category 

  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items
  
  before_create :generate_sku

  validates :sku, uniqueness: true

  
  def dimensions
    "#{height} x #{width} x #{length}"
  end
  
  private

  def generate_sku
    self.sku = SecureRandom.alphanumeric(20).upcase
  end
end
