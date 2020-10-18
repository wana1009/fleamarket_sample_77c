require 'rails_helper'

describe Item do
  describe '#create' do
    it '全てのバリデーションをクリアしていること' do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id)
      item.valid?
      expect(item).to be_valid
    end

    it "商品名がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品の説明がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, detail: "")
      item.valid?
      expect(item.errors[:detail]).to include("を入力してください")
    end

    it "カテゴリーの情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, brand_id: brand.id, category_id: "")
      item.valid?
      expect(item.errors[:category]).to include("を入力してください")
    end

    it "ブランドの情報がなくても登録できること" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: "")
      item.valid?
      expect(item).to be_valid
    end

    it "商品の状態の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, condition_id: "")
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    it "発送料の負担の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, charge_id: "")
      item.valid?
      expect(item.errors[:charge_id]).to include("を入力してください")
    end

    it "発送元の地域の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "発送までの日数の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, day_id: "")
      item.valid?
      expect(item.errors[:day_id]).to include("を入力してください")
    end

    it "価格の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, charge_id: "")
      item.valid?
      expect(item.errors[:charge_id]).to include("を入力してください")
    end
  end

  describe '#update' do
    it '全てのバリデーションをクリアしていること' do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id)
      item.valid?
      expect(item).to be_valid
    end

    it "商品名がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品の説明がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, detail: "")
      item.valid?
      expect(item.errors[:detail]).to include("を入力してください")
    end

    it "カテゴリーの情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, brand_id: brand.id, category_id: "")
      item.valid?
      expect(item.errors[:category]).to include("を入力してください")
    end

    it "ブランドの情報がなくても登録できること" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: "")
      item.valid?
      expect(item).to be_valid
    end

    it "商品の状態の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, condition_id: "")
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    it "発送料の負担の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, charge_id: "")
      item.valid?
      expect(item.errors[:charge_id]).to include("を入力してください")
    end

    it "発送元の地域の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "発送までの日数の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, day_id: "")
      item.valid?
      expect(item.errors[:day_id]).to include("を入力してください")
    end

    it "価格の情報がない場合は登録できないこと" do
      category = create(:category)
      brand = create(:brand)
      item = build(:item, category_id: category.id, brand_id: brand.id, charge_id: "")
      item.valid?
      expect(item.errors[:charge_id]).to include("を入力してください")
    end
  end
end