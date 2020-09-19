class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show]
  def index
    @items = Item.all.includes(:images)
  end

  def show
    @seller = @item.seller
    @user = @seller.user
    @category = @item.category
    @brand = @item.brand
    @images = @item.images
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

end
