class MessagesController < ApplicationController
  def index
    @messages = current_user.messages_received
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @recipient = User.find(params[:user_id])
  end

  def create
    message = Message.new(:sender => current_user, :recipient_id => params[:user_id], :message => params[:message][:message])
    message.save
  end

  def destroy
  end
end
