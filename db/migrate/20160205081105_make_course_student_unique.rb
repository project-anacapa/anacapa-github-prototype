class MakeCourseStudentUnique < ActiveRecord::Migration
  def change
    remove_index :courses_students, [:course_id, :student_id]
    add_index :courses_students, [:course_id, :student_id], unique: true
  end
end
