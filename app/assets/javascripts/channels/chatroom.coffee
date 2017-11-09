App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server
  
    # Called when there's incoming data on the websocket for this channel  
  received: (data) ->
    $('#messages').append data['message']
    $('#message_content').val ''# "message_content" refers to the div class "message" & the span class "content" in the _message partial.
    scrollToBottom()
    return
    
    #Loads all elements in the DOM with turbolinks then scrolls to bottom of the chat messages list.
    jQuery(document).on 'turbolinks:load', ->
      scrollToBottom()
      return
