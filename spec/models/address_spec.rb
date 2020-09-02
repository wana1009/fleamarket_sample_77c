require 'rails_helper'

describe Address do
  describe '#create' do
    it "is valid " do
      user    = build(:user)
      address = build(:address, user_id: user.id)
      address.valid?
      expect(address).to be_valid
    end

    it "is valid without building_name" do
      user    = build(:user)
      address = build(:address, user_id: user.id, building_name: "")
      address.valid?
      expect(address).to be_valid
    end

    it "is valid without phone number" do
      user    = build(:user)
      address = build(:address, user_id: user.id, phone_number: "")
      address.valid?
      expect(address).to be_valid
    end

    it "is invalid without first_name" do
      user    = build(:user)
      address = build(:address, user_id: user.id, first_name: "")
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください")
    end

    it "is invalid without last_name" do
      user    = build(:user)
      address = build(:address, user_id: user.id, last_name: "")
      address.valid?
      expect(address.errors[:last_name]).to include("を入力してください")
    end

    it "is invalid without first_kana" do
      user    = build(:user)
      address = build(:address, user_id: user.id, first_kana: "")
      address.valid?
      expect(address.errors[:first_kana]).to include("を入力してください")
    end

    it "is invalid without last_kana" do
      user    = build(:user)
      address = build(:address, user_id: user.id, last_kana: "")
      address.valid?
      expect(address.errors[:last_kana]).to include("を入力してください")
    end

    it "is invalid without postal_code" do
      user    = build(:user)
      address = build(:address, user_id: user.id, postal_code: "")
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end

    it "is invalid without prefecture_id" do
      user    = build(:user)
      address = build(:address, user_id: user.id, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end

    it "is invalid without town" do
      user    = build(:user)
      address = build(:address, user_id: user.id, town: "")
      address.valid?
      expect(address.errors[:town]).to include("を入力してください")
    end

    it "is invalid without house_number" do
      user    = build(:user)
      address = build(:address, user_id: user.id, house_number: "")
      address.valid?
      expect(address.errors[:house_number]).to include("を入力してください")
    end

    it "is invalid with incorrect postal_code format" do
      user    = build(:user)
      address = build(:address, user_id: user.id, postal_code: "1234567")
      address.valid?
      expect(address.errors[:postal_code]).to include("は不正な値です")
    end
  end
end