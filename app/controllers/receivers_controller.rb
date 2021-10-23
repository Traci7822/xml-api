class ReceiversController < ApplicationController
  def index
    @receivers = Receiver.all
    json_response(@receivers)
  end
end