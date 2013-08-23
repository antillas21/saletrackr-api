class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::StrongParameters

  respond_to :json

  before_action :authenticate_user!
  prepend_before_action :get_auth_token

  private
  def get_auth_token
    if auth_token = params[:token].blank? && request.headers["X-AUTH-TOKEN"]
      params[:token] = auth_token
    end
  end

  def authenticate_user!
    @current_user = User.where(authentication_token: params[:token]).first
    respond_with({ error: "Token is missing or is invalid." })  unless @current_user
  end

  def current_user
    @current_user
  end
end
