class FilersController < ApplicationController
  def index
    if filers.empty?
      redirect_to '/'
    else
     json_response(filers)
    end
  end

  def show
    json_response(filer)
  end

  private

  def filer
    Filer.find(params[:id])
  end

  def filers
    Filer.all
  end
end