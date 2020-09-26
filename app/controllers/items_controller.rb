class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show]
  def index
    @items = Item.all.includes(:images)
  end

  def new
    @category_parent_array = Category.where(ancestry: nil)
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").category_children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def show
    @seller = @item.seller
    @user = @seller.user
    @category = @item.category
    @brand = @item.brand
    @images = @item.images
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

end
