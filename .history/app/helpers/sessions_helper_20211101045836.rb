module SessionsHelper

    # Logs in the given user.
    def log_in(user)
      session[:user_id] = user.id
    end
  
    # Returns the current logged-in user (if any).
    def current_user
        if (user_id = session[:user_id])
          user = User.find_by(id: user_id)
          if user && session[:session_token] == user.session_token
            @current_user = user
          end
        elsif (user_id = cookies.encrypted[:user_id])
          user = User.find_by(id: user_id)
          if user && user.authenticated?(cookies[:remember_token])
            log_in user
            @current_user = user
          end
        end
      end
  
    # Returns true if the user is logged in, false otherwise.
    def logged_in?
      !current_user.nil?
    end

    def log_out
        reset_session
        @current_user = nil
      end
  end