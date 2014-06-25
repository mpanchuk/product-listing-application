class ProductsController < ApplicationController

  before_filter :load_product, only: [:show, :edit, :update, :destroy]

  def index
    @product = Product.new
    load_all_products
  end

  def create
    @product = Product.new permited_params
    if @product.save
      redirect_to products_path
    else
      load_all_products
      render "index"
    end
  end

  def edit
  end

  def update
    if @product.update_attributes permited_params
      redirect_to products_path
    else
      render "edit"
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def load_all_products
    @products = Product.all.paginate page: params[:page], per_page: 5
  end

  def load_product
    @product = Product.find params[:id]
  end

  def permited_params
    params[:product].permit :name, :description, :price
  end
end