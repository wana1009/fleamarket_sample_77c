class ItemsController < ApplicationController
  def index
    @items = Item.all.includes(:images)
  end
end
