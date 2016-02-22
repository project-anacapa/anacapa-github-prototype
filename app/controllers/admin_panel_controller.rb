class AdminPanelController < ApplicationController

  before_filter :authenticate_user!
  before_filter :admin_only

  def index
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

  def toggle_admin
    redirect_to :back, :notice => "You just toggled the is_admin role."
  end

  def toggle_instructor
    redirect_to :back, :notice => "You just toggled the is_instructor role."
  end

  private

  def admin_only
    unless current_user.has_role? :admin
      redirect_to :root, :alert => "You are not authorized to access this page."
    end
  end
end
