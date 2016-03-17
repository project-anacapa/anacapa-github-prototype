class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :edit_roster, :add_student, :remove_student, :csv_course_roster, :update, :destroy]
  load_and_authorize_resource

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
#    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # GET /courses/1/roster
  def edit_roster
    @students = @course.students
    @newstudent = (flash[:newstudent]) ? Student.new(flash[:newstudent]) : Student.new
  end

  def add_student
    @student = Student.get_student(params[:student].permit(:first_name, :last_name, :email, :studentid))
    if @student.is_a? String
      flash[:newstudent] = params[:student].permit(:first_name, :last_name, :email, :studentid)
      redirect_to :back, :alert => @student
    else
      @course.students << @student
      redirect_to :back, :notice => "Student successfully added to course."
    end
  end

  def remove_student
    @student = Student.find_by(studentid: params[:studentid])
    @student.courses.delete(@course)
    redirect_to :back, :alert => @student.first_name << " " << @student.last_name << " has been removed from this class."
  end

  def csv_course_roster
    begin
      @course.import(params[:file])
      redirect_to :back, :notice => "Students successfully added to course."
    rescue Exception => e
      redirect_to :back, :alert => "There were problems importing students from the file."
    end
  end

  def export_course_roster_csv
    csv_out = @course.export
    filename = @course.course_slug + "_roster.csv"
    send_data csv_out, :filename => filename
  end

  # POST /courses
  # POST /courses.json
  def create
#    @course = Course.new(course_params)

    respond_to do |format|
      @course.instructor = current_user
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params.merge(:instructor => current_user))
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
#      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:dept, :num, :desc, :term)
    end
end
