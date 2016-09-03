class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_ads
  
  layout :set_layout

  private
  def set_ads
    @ads = Ad.all
  end

  protected
  def set_layout
    "application"
  end

  def authenticate_checker!
  	redirect_to root_path, notice: "No eres un inspector" unless user_signed_in? && current_user.is_checker?
  end

  def authenticate_admin!
  	redirect_to root_path, notice: "No eres administrador" unless user_signed_in? && current_user.is_admin?
  end
end
