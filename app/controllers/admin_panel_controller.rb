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
    user = User.find(params[:id])
    toggle_to = !(user.has_role? :admin)
    if params.has_key? :toggle_to
      toggle_to = params[:toggle_to]
    end

    if toggle_to == true
      user.add_role "admin"
    else
      user.remove_role "admin"
    end

    respond_to do |format|
      format.json { render json: ["data" => "Setting is_admin of " + user.name + " to " + toggle_to + " and is now " + user.has_role?(:admin)]}
    end
  end

  def toggle_instructor
    user = User.find(params[:id])
    toggle_to = !(user.has_role? :instructor)
    if params.has_key? :toggle_to
      toggle_to = params[:toggle_to]
    end

    if toggle_to == true
      user.add_role "instructor"
    else
      user.remove_role "instructor"
    end

    respond_to do |format|
      format.json { render json: ["data" => "Setting is_instructor of " + user.name + " to " + toggle_to ]}
    end
  end

  private

  def admin_only
    unless current_user.has_role? :admin
      redirect_to :root, :alert => "You are not authorized to access this page."
    end
  end
end
