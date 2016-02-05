class Course < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :students
  belongs_to :instructor, class_name: "User", :foreign_key => :instructor
end
