# frozen_string_literal: true

class SuppliersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new supplier_params
    if @supplier.save
      flash[:notice] = 'Fornecedor registrado com sucesso'
      redirect_to @supplier
    else
      flash[:alert] = 'Não foi possível registrar o fornecedor'
      render 'new'
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit(:fantasy_name, :legal_name, :cnpj, :address, :phone, :email)
  end
end
