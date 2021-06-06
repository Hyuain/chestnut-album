require 'custom_error'

class ApplicationController < ActionController::API
  rescue_from CustomError::AuthorizationError, with: :render_must_sign_in

  def must_sign_in
    if current_user.nil?
      raise CustomError::AuthorizationError
    end
  end

  def current_user
    @current_user ||= User.find_by id: session[:current_user_id]
  end

  def render_resource(resource)
    return head :not_found if resource.nil?
    if resource[:errors].nil?
      render json: resource, status: 200
    else
      render json: resource.errors, status: 422
    end
  end

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

  def render_must_sign_in
    render status: :unauthorized
  end
end
