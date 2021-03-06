jQuery(document).ready ->

  pollDelay    = 1000
  interviewId  = $("#interview-id").val()
  postUrl      = "/chat/#{interviewId}"
  lastChatId   = 0
  publicOut    = $("#public-out")
  privateOut   = $("#private-out")

  appendMessage = (cm) ->
    if lastChatId < cm.id
      channel = if cm.channel is "private" then privateOut else publicOut
      txt = "<p class='chat_message'>#{cm.time} #{cm.name} #{cm.message}</p>"
      channel.append txt
      channel.get(0).scrollTop = channel.get(0).scrollHeight
      lastChatId = cm.id

  pollUrl = ->
    "/chat/#{interviewId}?after=#{lastChatId}"

  sendChat = (channel, txt) ->
    payload =
      channel: channel
      message: txt
    response = (data) ->
      appendMessage data.chat_message
    jQuery.post postUrl, payload, response, "json"

  pollChat = ->
    jQuery.getJSON pollUrl(), (data) ->
      appendMessage(c) for c in data
      setTimeout pollChat, pollDelay

  $("#public-out").click -> $("#public-in").focus()
  $("#private-out").click -> $("#private-in").focus()
  $("#public-in").bufferInput (txt) -> sendChat "public", txt
  $("#private-in").bufferInput (txt) -> sendChat "private", txt
  pollChat()
