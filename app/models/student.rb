class Student < ActiveRecord::Base
  has_and_belongs_to_many :courses
  belongs_to :user

  def self.get_student(params)
    email = params[:email]
    studentid = params[:studentid]

    s = Student.where(studentid: studentid).first
    if s.nil?
      s = Student.new(params.permit(:first_name, :last_name, :email, :studentid))
    elsif s.email != email
      if not Student.where(email: email).exists?
        # Keep our student roster up to date with registrar, and update all items
        s.email = email
        s.first_name = params[:first_name]
        s.last_name = params[:last_name]
        s.save
      else
        flash[:alert] = "The student could not be added."
        s = nil
      end
    end

    return s
  end
end
