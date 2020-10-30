class ItemsController < ApplicationController
  before_action :move_to_index,except: :index
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :show_all_instance, only: [:edit, :update]
  before_action :set_category_array, only: [:edit, :update]
  def index
    @items = Item.all.includes(:images)
  end

  def new
    @item = Item.new
    @item.images.new
    @seller = Seller.new
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
    @images = Image.where(item_id: params[:id])
    @category_grandchildren = @item.category
    @category_children = @category_grandchildren.parent
    @category_parent = @category_children.parent  
  end

  def destroy
    if current_user.id == @item.seller_id && @item.destroy
      render template: "items/destroy"
    else
      redirect_back(fallback_location: root_path)
    end
  end


  def pay
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      :amount => params[:amount],
      :card => params['payjp-token'],
      :currency => 'jpy'
    )
    @item.update(order_id: current_user.id)
  end
    
  def edit
    grandchild = @item.category
    child = grandchild.parent
    @parent_array = []
    @parent_array << @item.category.parent.parent.name
    @parent_array << @item.category.parent.parent.id
    @category_children_array = Category.where(ancestry: child.ancestry)
    @child_array = []
    @child_array << child.name
    @child_array << child.id 
    @category_grandchildren_array = Category.where(ancestry: grandchild.ancestry)
    @grandchild_array = []
    @grandchild_array << grandchild.name
    @grandchild_array << grandchild.id
  end

  def update
    if item_params[:images_attributes].nil?
      render :edit
    else
      exit_ids = []
      item_params[:images_attributes].each do |a,b|
        exit_ids << item_params[:images_attributes].dig(:"#{a}",:id).to_i
      end
      ids = Image.where(item_id: params[:id]).map{|image| image.id }
      delete__db = ids - exit_ids
      Image.where(id:delete__db).destroy_all
      @item.touch
      if @item.update(item_params)
        redirect_to  update_done_items_path
      else
        render :edit
      end
    end
  end

  def update_done
    @item_update = Item.order("updated_at DESC").first
  end

  private
  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :condition_id, :charge_id, :prefecture_id, :day_id, :price, images_attributes: [:url, :_destroy, :id] ).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_category_array
    @category_parent_array = Category.where(ancestry: nil).each do |parent|
    end
  end

  def show_all_instance
    @user = User.find(@item.seller_id)
    @images = Image.where(item_id: params[:id])
    @images_first = Image.where(item_id: params[:id]).first
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  private

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

end