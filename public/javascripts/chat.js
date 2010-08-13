(function() {
  jQuery(document).ready(function() {
    return $("#public-in").bufferInput(function(txt) {
      var interview_id, url;
      interview_id = $("#interview-id").val();
      url = ("/chat/" + (interview_id));
      return jQuery.post(url, {
        message: txt
      });
    });
  });
})();
