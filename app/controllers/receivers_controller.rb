class ReceiversController < ApplicationController
  def index
    if receivers.empty?
      redirect_to '/'
    else
      json_response(receivers)
    end
  end

  private

  def receivers
    if params['state']
      state_receivers = Receiver.where(state: params['state'].upcase)
      #TODO json_resp here?
      state_receivers.empty? ? {error: "No receivers found"} : state_receivers
    else
      Receiver.all
    end
  end
end