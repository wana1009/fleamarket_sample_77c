class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show]
  def index
    @items = Item.all.includes(:images)
  end

  def new
    @item = Item.new
    @category_parent = Category.where
  
  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end
  
  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
  
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

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :charge_id, :prefecture_id, :days_id, :price, images: []).merge(user_id: current_user.id, boughtflg_id:"1")
  end

end
