FactoryGirl.define do
  factory :comment do
    association :post
    association :user
    body "Yrroonn ru ooma roo ahuma ur roooarrgh hnn-rowr."
  end
end
