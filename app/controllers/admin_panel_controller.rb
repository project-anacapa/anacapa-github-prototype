class AdminPanelController < ApplicationController

  before_filter :authenticate_user!
  before_filter :admin_only

  def list
    @users = User.all
  end
   
  def show
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

  private

  def admin_only
    unless current_user.has_role? :admin
      redirect_to :back, :alert => "Access denied"
    end
  end
end
