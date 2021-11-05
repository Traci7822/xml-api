class AwardsController < ApplicationController  
  def index
    # if awards.empty?
      # redirect_to '/'
    # else
    json_response(awards)
    # end
  end

  def show
    json_response(award)
  end

  private

  def award
    Award.find(params[:id])
  end

  def awards
    Award.all.order('id ASC').includes(:filer)
  end
end