class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # render text:request.env['omniauth.auth'].to_json
    session[:github_data] = request.env["omniauth.auth"]
    session[:user_id] = @user.id

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "GitHub") if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
