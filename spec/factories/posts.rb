FactoryGirl.define do
  factory :post do
    association :user
    title "Minerva Aplicativos"
    body "Os aplicativos da Minerva são desenvolvidos nativamente em cada plataforma"
  end
end
