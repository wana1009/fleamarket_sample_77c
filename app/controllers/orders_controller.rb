class OrdersController < ApplicationController
  require "payjp"

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  def buy
    @item = Item.find(params[:id])
    @images = @item.images.all

    if user_signed_in?
      @user = current_user
      if @user.card.present?
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        @card = Card.find_by(user_id: current_user.id)
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @customer_card = customer.cards.retrieve(@card.card_id)

        @exp_month = @customer_card.exp_month.to_s
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      else
      end
    else
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def pay
    @item = Item.find(params[:id])
    @images = @item.images.all

    if @item.order.present?
      redirect_to item_path(@item.id), alert: "売り切れています。"
    else
      # 二重で決済されるのを防ぐ
      @item.with_lock do
        if current_user.card.present?
          # ログインユーザーがクレジットカード登録済みの場合
          @card = Card.find_by(user_id: current_user.id)
          Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
          charge = Payjp::Charge.create(
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # 
          # Payjp::Charge.create(
          #   amount: @item.price,
          #   card: params['payjp-token'],
          #   currency: 'jpy'
          # )
        end
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:price)
  end

end