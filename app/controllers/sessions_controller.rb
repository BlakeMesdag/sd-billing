class SessionsController < ApplicationController
  skip_before_filter :ensure_user_logged_in, :verify_authenticity_token

  def new
    redirect_to '/auth/google'
  end

  def create
    redirect_to = session[:redirect_to]
    reset_session

    if auth = request.env['omniauth.auth']
      session[:active] = 1
      redirect_to redirect_to.nil? ? "/" : redirect_to
    end
  end

  def destroy
    reset_session
    render text: "Logged out, goodbye"
  end

  def failure
    render text: "Snowman Says No"
  end
end
