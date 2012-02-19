FactoryGirl.define do
  factory :user do
    name                  "default"
    email                 { "#{name}@conquest-on-rails.org".downcase }
    password              { name.downcase }
    password_confirmation { name.downcase }


    factory :alpha do
      name "Alpha"
    end

    factory :beta do
      name "Beta"
    end

    factory :gamma do
      name "Gamma"
    end

    factory :delta do
      name "Delta"
    end

    factory :epsilon do
      name "Epsilon"
    end
  end
end
