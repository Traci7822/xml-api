class FilersController < ApplicationController
  def index
    if filers.empty?
      redirect_to '/'
    else
      json_response(filers)
    end
  end

  private

  def filers
    Filer.all
  end
end