class MessagesController < ApplicationController
  before_action :require_user
  
  
  def create
    @message = Message.new(message_params)#Assigns new message to the @message object.
    @message.chef = current_chef#Ensure a logged in chef
    if @message.save
      #redirect_to chat_path
       ActionCable.server.broadcast 'chatroom_channel', message: render_message(@message),#'render_message' method passes in @message - different technique from that in comments_controller.rb. 
                                                        chef: @message.chef.chefname#Gets the current chef name.
    else
      redirect_to 'chatrooms/show'
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
  
  def render_message(message)
    render(partial: 'message', locals: { message: message } )#Renders the _message partial by specifying the local object message.
  end
end
# In Rails it is very advisable to not use any instance variables inside your partials if you want to re-use 
#that partial in a different context.  It is much better to simply leverage locals that you pass into your 
#render as we have done in the render_message method above.