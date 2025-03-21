# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  respond_to :json
  private
  # before_action :configure_sign_in_params, only: [:create]
  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: "Logged in sucessfully." },
      data: AdminSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
      if current_admin
      Rails.logger.debug "Current admin: #{current_admin.inspect}"
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
      else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
      end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
