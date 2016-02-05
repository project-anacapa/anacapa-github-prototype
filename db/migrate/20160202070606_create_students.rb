class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :studentid
    end

    create_table :courses_students, :id => false do |t|
      t.integer :course_id
      t.integer :student_id
    end

    add_index :courses_students, [:course_id, :student_id]
  end
end
