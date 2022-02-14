# frozen_string_literal: true

class ProductBundleItem < ApplicationRecord
  belongs_to :product_bundle
  belongs_to :product_model
end
