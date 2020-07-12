module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id # Encrypting user_id using signed method
    cookies.permanent[:remember_token] = user.remember_token # Don't need to encrypt since we don't store this in db
  end

  # Forgets a user
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns the current logged-in user (if any). Checks user login status.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id) # Gets user_id value from cookie
      if user && user.authenticated?(:remember, cookies[:remember_token]) # Check if remember_token matches remember_digst in db
        log_in user
        @current_user = user
      end
    end
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns true if current user is admin
  def admin?
    current_user.admin?
  end

  #### Next 2 methods are for friendly forwarding ####

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
