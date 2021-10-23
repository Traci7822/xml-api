class FilersController < ApplicationController
  def index
    @filers = Filer.all
    json_response(@filers)
  end
end