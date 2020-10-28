class OrdersController < ApplicationController
  require "payjp"

  def buy
    @item = Item.find(params[:item_id])
    @images = @item.images.all

    if user_signed_in?
      @user = current_user
      if @user.card.present?
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        @card = Card.find_by(user_id: current_user.id)
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @customer_card = customer.cards.retrieve(@card.card_id)

        @card_brand = @customer_card.brand
        case @card_brand
        when "Visa"
          @card_src = "visa.png"
        when "JCB"
          @card_src = "jcb.png"
        when "MasterCard"
          @card_src = "master.png"
        when "American Express"
          @card_src = "amex.png"
        when "Diners Club"
          @card_src = "diners.png"
        when "Discover"
          @card_src = "discover.png"
        end
        # viewの記述を簡略化
        @exp_month = @customer_card.exp_month.to_s
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      else
      end
    else
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def pay
    @item = Item.find(params[:item_id])
    @images = @item.images.all

    if @item.order.present?
      redirect_to item_path(@item.id), alert: "売り切れています。"
    else
      # 同時に2人が同時に購入し、二重で購入処理がされることを防ぐための記述
      @item.with_lock do
        if current_user.card.present?
          @card = Card.find_by(user_id: current_user.id)
          Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
          charge = Payjp::Charge.create(
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # APIの「Checkout」ライブラリによる決済処理の記述
          Payjp::Charge.create(
          amount: @item.price,
          card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
          currency: 'jpy'
          )
        end
      # #購入テーブルに登録処理
      # @order = Order.create(seller_id: current_user.id, item_id: params[:item_id])
      end
    end
  end
end