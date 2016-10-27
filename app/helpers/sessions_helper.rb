module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  # Retrieve the current logged-in user, if a session is active.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Check whether there is a logged-in user
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
