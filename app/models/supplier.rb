# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_many :product_models, dependent: nil

  validates :fantasy_name, :legal_name, :cnpj, :email, presence: true
  validates :cnpj, uniqueness: true
  validates :cnpj, format: { with: /\A\d{14}\z/, message: 'deve conter 14 dígitos' }
end
