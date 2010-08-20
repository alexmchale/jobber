$(document).ready ->

  templateList      = $("#template")
  documentList      = $("#document")
  interviewDocument = $("#interview-document")
  interviewId       = $("#interview-id").val()
  serverData        = interviewDocument.val()
  documentId        = documentList.val()
  syncDelay         = 500
  synchronizing     = true
  dmp               = new diff_match_patch()
  patchLevel        = $("#patch-level").val()

  updateDocumentList = ->
    documentsUrl = "/documents?interview_id=#{interviewId}"
    jQuery.getJSON documentsUrl, (datas) ->
      options = for data in datas
        doc = data.document
        sel = if doc.id == documentId then ' selected="selected"' else ''
        "<option value='#{doc.id}'#{sel}>#{doc.name}</option>"
      documentList.html options.join("")

  createDocument = ->

    context =
      interview_id: interviewId
      template_id:  templateList.val()

    newDocumentFunc = (data) ->
      updateDocumentList data.document.id
      setDocument data.document.id, data.document.content

    jQuery.post "/documents", context, newDocumentFunc, "json"

  loadDocument = ->

    setDocument documentList.val(), ""
    patchLevel = 0

    url = "/documents/" + documentList.val() + "?make_current=true"
    synchronizing = false

    jQuery.getJSON url, (data) ->

      setDocument data.document.id, data.document.content
      synchronizing = true

  updateDocument = (destinationData) ->

    diff   = dmp.diff_main(interviewDocument.val(), destinationData)
    cursor = interviewDocument.getSelection() || { start: 0, end: 0 }
    offset = 0

    interviewDocument.setSelection 0, 0

    for [ type, text ] in diff

      switch type
        when -1
          interviewDocument.setSelection offset, offset + text.length
          interviewDocument.replaceSelection ""
          if offset < cursor.start
            cursor.start -= text.length
            cursor.end   -= text.length
        when 0
          offset += text.length
        when +1
          interviewDocument.setCaretPos offset + 1
          interviewDocument.insertAtCaretPos text
          if offset < cursor.start
            cursor.start += text.length
            cursor.end   += text.length
          offset += text.length

    interviewDocument.setSelection cursor.start, cursor.end

  merge = (data) ->

    if patch = data?.document_patch

      localData = interviewDocument.val()

      if patch.content != localData

        d1 = dmp.diff_main(serverData, localData)
        p1 = dmp.patch_make(serverData, localData, d1)
        r1 = dmp.patch_apply(p1, patch.content)

        updateDocument r1[0]

      serverData = patch.content
      patchLevel = patch.id

    else

      alert "clearing server info"

      serverData = ""
      patchLevel = 0

    setTimeout syncTimer, syncDelay

  syncTimer = ->

    return unless synchronizing

    patchUrl  = "/documents/patch/#{documentId}"
    localData = interviewDocument.val()

    if serverData != localData
      context =
        patch_id: patchLevel
        content:  localData

      serverData = localData

      jQuery.post patchUrl, context, merge, "json"
    else
      jQuery.getJSON patchUrl, merge

  documentList.change loadDocument
  $("#new-document").click createDocument
  syncTimer()
