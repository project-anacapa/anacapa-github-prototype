class LinkInstructorToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :term, :string
    add_column :courses, :instructor, :integer
    add_foreign_key :courses, :users, column: :instructor
  end
end
