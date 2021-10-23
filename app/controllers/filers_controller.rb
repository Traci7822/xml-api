class FilersController < ApplicationController
  def index
    @filers = Filer.all
    if @filers.count == 0
      redirect_to '/'
    else
      json_response(@filers)
    end
  end
end