jQuery(document).ready ->

  pollDelay    = 1000
  interviewId  = $("#interview-id").val()
  postUrl      = "/chat/#{interviewId}"
  lastChatId   = 0
  publicOut    = $("#public-out")

  appendMessage = (cm) ->
    if lastChatId < cm.id
      txt = "<p class='chat_message'>#{cm.message}</p>"
      publicOut.append txt
      publicOut.get(0).scrollTop = publicOut.get(0).scrollHeight
      lastChatId = cm.id

  pollUrl = ->
    "/chat/#{interviewId}?after=#{lastChatId}"

  sendChat = (txt) ->
    response = (data) ->
      appendMessage data.chat_message
    jQuery.post postUrl, { message: txt }, response, "json"

  pollChat = ->
    jQuery.getJSON pollUrl(), (data) ->
      appendMessage(c.chat_message) for c in data
      setTimeout pollChat, pollDelay

  $("#public-in").bufferInput sendChat
  pollChat()
