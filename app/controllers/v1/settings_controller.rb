class V1::SettingsController < ApplicationController
  # before_action :fetch_resource

  def index
    @settings = current_user.account_setting
    respond_with @settings, location: v1_my_settings_url
  end

  private
  def fetch_resource
    super(:account_settings)
  end
end