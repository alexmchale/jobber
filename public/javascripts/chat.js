(function() {
  jQuery(document).ready(function() {
    var appendMessage, interviewId, lastChatId, pollChat, pollDelay, pollUrl, postUrl, publicOut, sendChat;
    pollDelay = 1000;
    interviewId = $("#interview-id").val();
    postUrl = ("/chat/" + (interviewId));
    lastChatId = 0;
    publicOut = $("#public-out");
    appendMessage = function(cm) {
      var txt;
      if (lastChatId < cm.id) {
        txt = ("<p class='chat_message'>" + (cm.message) + "</p>");
        publicOut.append(txt);
        publicOut.get(0).scrollTop = publicOut.get(0).scrollHeight;
        return (lastChatId = cm.id);
      }
    };
    pollUrl = function() {
      return "/chat/" + (interviewId) + "?after=" + (lastChatId);
    };
    sendChat = function(txt) {
      var response;
      response = function(data) {
        return appendMessage(data.chat_message);
      };
      return jQuery.post(postUrl, {
        message: txt
      }, response, "json");
    };
    pollChat = function() {
      return jQuery.getJSON(pollUrl(), function(data) {
        var _a, _b, _c, c;
        _b = data;
        for (_a = 0, _c = _b.length; _a < _c; _a++) {
          c = _b[_a];
          appendMessage(c.chat_message);
        }
        return setTimeout(pollChat, pollDelay);
      });
    };
    $("#public-in").bufferInput(sendChat);
    return pollChat();
  });
})();
