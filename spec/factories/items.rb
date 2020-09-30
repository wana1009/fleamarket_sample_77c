FactoryBot.define do

  factory :item do
    name           {"Tシャツ"}
    detail         {"ユニクロ"}
    price          {"3000"}
    size           {"M"}
    condition_id   {"1"}
    charge_id      {"1"}
    prefecture_id  {"1"}
    day_id         {"1"}
    seller_id      {"1"}
    order_id       {"1"}
    # category_id    {"1"}
    # brand_id       {"1"}
  end    
end