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
    patchLevel    = 0
    url           = "/documents/patch/#{documentList.val()}?make_current=true"
    synchronizing = false
    jQuery.getJSON url, (data) ->
      documentId = data.document_patch.document_id
      serverData = data.document_patch.content
      patchLevel = data.document_patch.id
      interviewDocument.val serverData
      synchronizing = true

  # Turn the current document into the given one, while maintaining the cursor
  # position. This allows the user to keep typing after an update.
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

      if documentId != patch.document_id

        # We have switched documents, throw away any pending changes.

        documentId = patch.document_id
        interviewDocument.val patch.content
        documentList.val documentId

      else if patch.content != localData

        # The data on the server has changed, update the local data.

        d1 = dmp.diff_main(serverData, localData)
        p1 = dmp.patch_make(serverData, localData, d1)
        r1 = dmp.patch_apply(p1, patch.content)

        updateDocument r1[0]

      serverData = patch.content
      patchLevel = patch.id

    else

      serverData = ""
      patchLevel = 0

    setTimeout syncTimer, syncDelay

  syncTimer = ->

    return unless synchronizing

    patchUrl  = "/documents/patch/#{documentId}"
    queryUrl  = "/documents/patch/current?interview_id=#{interviewId}"
    localData = interviewDocument.val()

    if serverData != localData
      context =
        patch_id: patchLevel
        content:  localData

      serverData = localData

      jQuery.post patchUrl, context, merge, "json"
    else
      jQuery.getJSON queryUrl, merge

  documentList.change loadDocument
  $("#new-document").click createDocument
  syncTimer()
