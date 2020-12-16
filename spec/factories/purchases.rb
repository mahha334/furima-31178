FactoryBot.define do
  factory :user_purchase do
    postcd  {"100-0001"}  # ハイフン必須
    city {"横浜市緑区"}
    addressb  {"青山1−1−1"} 
    phone   {12345678912} # 11桁以内
    area_id {1}          # プルダウンなので番号指定（共通の数字）

    end
end
