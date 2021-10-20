class AwardsController < ApplicationController
  def index
    @awards = Award.all
    json_response(@awards)
  end
end