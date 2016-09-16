class HomeController < ApplicationController
  before_action :authenticate_admin!, only: [:dashboard]

  def index
  end

  def main
  	@ads = Ad.all
  end

  def dashboard
  end
  
  protected
  def set_layout
    return "landing" if action_name == "main"
    super
  end
end
