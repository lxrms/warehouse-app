# frozen_string_literal: true

class ProductItem < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product_model
end
