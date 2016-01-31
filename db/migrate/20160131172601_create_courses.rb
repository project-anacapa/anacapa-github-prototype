class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :dept
      t.string :num
      t.string :desc

      t.timestamps null: false
    end
  end
end
