class Course < ActiveRecord::Base
  require 'csv'

  resourcify
  has_and_belongs_to_many :students
  belongs_to :instructor, class_name: "User", :foreign_key => :instructor

  def import(file)
    failed = []
    fpath = ""
    begin
      fpath = file.path
    rescue Exception => e
      raise e
    end
    CSV.foreach(file.path, headers: true) do |row|

      stdt_hash = row.to_hash
      if stdt_hash.has_key? "studentid" and stdt_hash.has_key? "email"
        begin
          stdt = Student.find_or_create_by(studentid: stdt_hash["studentid"])
          stdt.update_attributes(stdt_hash)
          stdt.courses << self
        rescue
          failed << stdt_hash
        end
      else
        failed << stdt_hash
      end # end if stdt_hash.has_key? "id" and stdt_hash.has_key? "email"
    end # end CSV.foreach
    return failed
  end # end import(file)

  def course_slug
    return self.dept + self.num + "_" + self.term
  end

  def export
    csv_out = "studentid,email,first_name,last_name"
    students = self.students
    students.each do |s|
      csv_out << "\n" + s.studentid + "," + s.email + "," + s.first_name + "," + s.last_name
    end
    return csv_out
  end
end
