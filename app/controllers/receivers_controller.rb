class ReceiversController < ApplicationController
  def index
    if receivers.empty?
      redirect_to '/'
    else
      json_response(receivers)
    end
  end

  def receivers
    if params['state']
      Receiver.where(state: params['state'].upcase)
    else
      Receiver.all
    end
  end
end