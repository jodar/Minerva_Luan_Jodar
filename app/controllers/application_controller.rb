class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def get_current_user
    return nil unless cookies[:auth_headers]
    auth_headers = JSON.parse cookies[:auth_headers]

    expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
    current_user = User.find_by(uid: auth_headers["uid"])

    if current_user &&
      current_user.tokens.has_key?(auth_headers["client"]) &&
      expiration_datetime > DateTime.now

      @current_user = current_user
    end

    @current_user
  end
end
