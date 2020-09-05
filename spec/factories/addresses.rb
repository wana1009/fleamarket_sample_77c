FactoryBot.define do

  factory :address do
    # user_id               {1}
    first_name              {"山田"}
    last_name               {"太郎"}
    first_kana              {"ヤマダ"}
    last_kana               {"タロウ"}
    postal_code             {"123-4567"}
    prefecture_id           {1}
    town                    {"渋谷区"}
    house_number            {"1-1-1"}
    building_name           {"tech::expert101"}
    phone_number            {"09012345678"}
  end

end