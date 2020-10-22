class CardController < ApplicationController
  require "payjp"
  before_action :set_card, only: [:confirmation, :destroy, :show]

  def confirmation
    redirect_to action: "show",id: current_user.id if @card.present?
  end

  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] #秘密鍵
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show", id: current_user.id
      else
        redirect_to action: "new"
      end
    end
  end

  def destroy
    if @card.present?
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      redirect_to action: "confirmation"
    end
  end

  def show
    if @card.blank?
      redirect_to action: "confirmation"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] #秘密鍵
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  private

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end
end
