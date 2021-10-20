class FilersController < ApplicationController
  def index
    @filers = Filer.all
    json_response(@awards)
  end
end