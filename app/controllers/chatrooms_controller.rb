class ChatroomsController < ApplicationController
  before_action :require_user
  
  def show
    @message = Message.new
    @messages = Message.most_recent#Displays most recent messages first.  Calls most_recent, defined in message.rb
  end
  
end