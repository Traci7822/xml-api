class ReceiversController < ApplicationController
  def index
    @receivers = Receiver.all
    json_response(@awards)
  end
end