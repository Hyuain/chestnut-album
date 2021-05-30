class ApplicationController < ActionController::API
  # before_action :authenticate_user

  private

  # def authenticate_user
  #   redirect_to root_path unless current_user
  # end
  #
  # def current_user
  #   @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  # end
  #
  # def user_sign_in(user)
  #   session[:current_user_id] = user.id
  # end
  #
  # def user_sing_out
  #   session[:current_user_id] = nil
  #   @_current_user = nil
  # end
end
