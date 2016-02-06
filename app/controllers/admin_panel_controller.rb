class AdminPanelController < ApplicationController

  before_filter :authenticate_user!
  before_filter :admin_only

  def index
    @users = User.all
  end
   
  def show
    @users = User.all
  end
   
  def new
  end
   
  def create
  end
   
  def edit
  end
   
  def update
  end
   
  def delete
  end

  def toggle_admin
  end

  def toggle_instructor
  end

  private

  def admin_only
    unless current_user.has_role? :admin
      redirect_to :root, :alert => "You are not authorized to access this page."
    end
  end
end
