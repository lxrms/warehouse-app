# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all
  end


  def search
    term = params[:search]
    @warehouses = Warehouse.all
    @warehouses = @warehouses.filter {|w| w.name.downcase.include?(term.downcase) ||
                                          w.code.downcase.include?(term.downcase) ||
                                          w.city.downcase.include?(term.downcase)}
    render 'index'
  end

end
