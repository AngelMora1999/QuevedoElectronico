class HomeController < ApplicationController
  before_action :authenticate_admin!, only: [:dashboard]

  def index
  end

  def main
  	@ads = Ad.all
  end

  def dashboard
    @users = User.all
    @ads = Ad.all
  end
  
  protected
  def set_layout
    return "landing" if action_name == "main"
    super
  end
end
