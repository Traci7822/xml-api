class AwardsController < ApplicationController  
  def index
    if awards.empty?
      redirect_to '/'
    else
      json_response(awards)
    end
    end

  def awards
    Award.all
  end
end