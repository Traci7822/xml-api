class ReceiversController < ApplicationController
  def index
    json_response(receivers)
  end

  def receivers
    if params['state']
      Receiver.where(state: params['state'].upcase)
    else
      Receiver.all
    end
  end
end