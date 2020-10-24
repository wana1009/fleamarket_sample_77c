class CardController < ApplicationController
  require "payjp"
  before_action :set_card, only: [:confirmation, :destroy, :show]

  def confirmation
    redirect_to action: "show",id: current_user.id if @card.present?
  end

  def new
    @card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if @card.exists?
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
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
        # redirect_to action: "show", id: current_user.id
      else
        redirect_to action: "create"
      end
    end
  end

  def destroy
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete

      if @card.destroy

      else
        redirect_to credit_card_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end

  def show
    @card = CreditCard.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)

      @exp_month = @customer_card.exp_month.to_s
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  private

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end
end