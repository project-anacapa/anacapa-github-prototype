class Course < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :students
end
