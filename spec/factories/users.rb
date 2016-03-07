FactoryGirl.define do

  factory :user do
  	name 'Test Name'
    email 'test@example.com'
    #password 'f4k3p455w0rd'
    id '12345'

    factory :admin do
      after(:create) { |user| user.add_role(:admin) }
    end
  end

  # factory :admin, class: User do
  # 	name 'Admin Name'
  #   email 'test@example.admin'
  #   #password 'f4k3p455w0rdadmin'
  #   id '123456789'
  #   is_admin true
  # end

end
