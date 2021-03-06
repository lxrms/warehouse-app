# frozen_string_literal: true

class ProductBundle < ApplicationRecord
  has_many :product_bundle_items, dependent: nil
  has_many :product_models, through: :product_bundle_items
end
