class ReceiversController < ApplicationController
  def index
    # if receivers.empty?
    #   redirect_to '/'
    # else
    json_response(receivers)
    # end
  end

  def show
    json_response(receiver)
  end

  private

  def receiver
    Receiver.find(params[:id])
  end

  def receivers
    if params['state']
      state_receivers = Receiver.where(state: params['state'].upcase)
      state_receivers.empty? ? {error: "No receivers found"} : state_receivers
    else
      Receiver.all
    end
  end
end