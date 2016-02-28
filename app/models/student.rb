class Student < ActiveRecord::Base
  has_and_belongs_to_many :courses
  belongs_to :user

  def self.new_student(params)
    ps = params.permit(:first_name, :last_name, :email, :studentid)
    fn = params[:first_name]
    sn = params[:last_name]
    em = params[:email]
    id = params[:studentid]

    if fn.to_s.strip.length == 0
      return "The student must have a first name."
    end
    if sn.to_s.strip.length == 0
      return "The student must have a last name."
    end
    if em.to_s.strip.length == 0
      return "The student must have an email address."
    end
    if id.to_s.strip.length == 0
      return "The student must have a student id."
    end

    return Student.new(params.permit(:first_name, :last_name, :email, :studentid))
  end

  def self.get_student(params)
    email = params[:email]
    studentid = params[:studentid]

    s = Student.where(studentid: studentid).first
    if s.nil?
      s = Student.new_student(params)
    elsif s.email != email
      if not Student.where(email: email).exists?
        # Keep our student roster up to date with registrar, and update all items
        s.email = email
        s.first_name = params[:first_name]
        s.last_name = params[:last_name]
        s.save
      else
        return "The student could not be added."
      end
    end

    return s
  end
end
