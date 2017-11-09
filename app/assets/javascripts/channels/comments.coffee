App.comments = App.cable.subscriptions.create "CommentsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#messages .comment-fix:first").prepend(data)# Called when there's incoming data on the websocket for this channel - Adds latest comment to top of comments list.
    #.comment-fix:first calls the row comment-fix class in the _comment partial and adds it to the top of the comments list as the "first" message. 
