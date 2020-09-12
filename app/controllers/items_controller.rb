class ItemsController < ApplicationController
  def index
    @items = Item.all.includes(:images)
  end

  def show
    @item = Item.find(params[:id])
  end

end
