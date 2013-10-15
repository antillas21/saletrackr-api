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
    if params[:token]
      @current_user = User.where(authentication_token: params[:token]).first
      respond_with(
        {
          error: {
            message: "Authentication Token invalid. You must provide a valid authentication token in your request.",
            type: 'Authentication Error.'
          }
          }, status: 401
      )  unless @current_user
    else
      respond_with(
        {
          error: {
            message: 'Authentication Token missing. You must provide an authentication token in your request.',
            type: 'Authentication Error.'
          }
        }, status: 401
      )
    end
  end

  def current_user
    @current_user
  end

  def fetch_resource( resource_name )
    resource = resource_name.to_s.singularize.camelize.constantize.find( params[:id] )
    if current_user.send(resource_name).include?(resource)
      @resource = resource
    else
      render json: authorization_error_message, status: 403
    end
  rescue ActiveRecord::RecordNotFound
    render json: resource_not_found_error_message, status: 404
  end

  def authorization_error_message
    {
      error: {
        type: 'Authorization Error.',
        message: 'Authorization Failure. You do not have permission to access the resource you requested.'
      }
    }
  end

  def resource_not_found_error_message
    {
      error: {
        message: 'Resource Not Found Error. The resource you requested could not be found. It may been removed or you may be using a wrong ID',
        type: 'Resource Not Found Error.'
      }
    }
  end
end
