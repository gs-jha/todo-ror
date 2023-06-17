module SessionsHelper
    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        if session[:user_id]
            # User is logged in
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        !current_user.nil?
    end

    # Logs out the current user
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

    # security check, ensure user is signed in, if not, redirect to signin page.
    def logged_in_user
        unless logged_in?
        store_location
        redirect_to login_url
        end
    end

    # store the current location to support the redirect_back feature
    def store_location
        session[:return_to] = request.url if request.get?
    end
    
end
