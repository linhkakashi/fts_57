FactoryGirl.define do
  factory :admin, class: User do
    name "supera"
    email "supera@gmail.com"
    password "03051994"
    password_confirmation "03051994"
    is_admin true
  end

  factory :user do
    name "usenames"
    email "tlinh@gmail.com"
    password "03051994"
    password_confirmation "03051994"
    is_admin false
  end
end
