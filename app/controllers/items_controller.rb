class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :destroy]
  def index
    @items = Item.all.includes(:images)
  end

  def new
    @item = Item.new
    @item.images.new
    @seller = Seller.new
    @category_parent_array = ["---"]
    @category_parent_array = Category.where(ancestry: nil)
  end
  
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end
  
  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      @seller = Seller.new({item_id: @item.id, user_id: current_user.id})
      if @seller.save
        redirect_to root_path
      else
        render :new
      end
  
    else
      render :new
    end
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

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :condition_id, :charge_id, :prefecture_id, :day_id, :price, images_attributes: [:url] ).merge(seller_id: current_user.id)

  end

end
