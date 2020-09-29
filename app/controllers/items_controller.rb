class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :destroy]
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
    if current_user.id == @item.seller_id && @item.destroy
      render template: "items/destroy"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

end
