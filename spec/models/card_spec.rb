require 'rails_helper'

describe CreditCard do
  describe 'card#create' do
    it "is valid with a customer_id, card_id, user_id" do
      card = build(:credit_card)
      expect(card).to be_valid
    end

    it "is invalid without a customer_id" do
      credit_card = build(:card, customer_id: nil)
      credit_card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください。")
    end

    it "is invalid without a card_id" do
      card = build(:card, card_id: nil)
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください。")
    end
  end
end