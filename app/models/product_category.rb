# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true
end
