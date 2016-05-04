class Api::ProductsController < ApplicationController
  before_action :require_current_user, only: :create
  before_action :require_correct_user, only: [:update, :destroy]

  def index
    result = Product.search(params[:opts])
    @products = result[:products]
    @scores = result[:scores]
    render :index
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    img_urls = params[:product][:img_urls]
    @product.img_urls = img_urls
    @product.user = current_user
    if @product.save
      render json: @product
    else
      render json: @product.errors.full_messages, status: 422
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors.full_messages, status: 422
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.deactivate!
      render json: @product
    else
      render json: @product.errors.full_messages, status: 422
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :lat, :lng, :price)
  end

  def require_correct_user
    @product = current_user.products.find(params[:id])
    render json: {status: 422, errors: {}} unless @product
  end
end
