# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all
  end


  def search
    term = params[:search]
    @warehouses = Warehouse.where 'name like ? OR code like ? OR city like ?',
                                  "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%"
    render 'index'
  end

end
