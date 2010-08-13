jQuery(document).ready ->

  $("#public-in").bufferInput (txt) ->

    interview_id = $("#interview-id").val()
    url = "/chat/#{interview_id}"

    jQuery.post url, { message: txt }
