require 'rails_helper'

describe Item do
  describe '#create' do
    it '全てのバリデーションをクリアしていること' do
      item = build(:item)
      item.valid?
      expect(item).to be_valid
    end
  end
end