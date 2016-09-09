class HomeController < ApplicationController
  def index
  end

  def main
  	@ads = Ad.all.ultimos
  end
  
  protected
  def set_layout
    return "landing" if action_name == "main"
    super
  end
end
