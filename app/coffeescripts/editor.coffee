$(document).ready ->

  templateList =      $("#template")
  documentList =      $("#document")
  interviewDocument = $("#interview-document")
  interviewId =       $("#interview-id").val()
  previousData =      interviewDocument.val()
  documentId =        documentList.val()
  syncDelay =         1000
  synchronizing =     true

  setDocument = (id, content) ->
    documentId = id if id isnt undefined
    previousData = content
    interviewDocument.html content

  updateDocumentList = (selectedDocumentId) ->

    documentsUrl = "/documents?interview_id=" + interviewId

    jQuery.getJSON documentsUrl, (datas) ->
      options = ""
      for data in datas
        doc = data.document
        sel = if doc.id is selectedDocumentId then ' selected="selected"' else ''
        options += '<option value="' + doc.id + '"' + sel + '>' + doc.name + '</option>'
      documentList.html options

  createDocument = ->

    templateId = templateList.val()

    newDocumentUrl  = "/documents"
    newDocumentUrl += "?interview_id=" + interviewId
    newDocumentUrl += "&template_id=" + templateId

    newDocumentFunc = (data) ->
      updateDocumentList data.document.id
      setDocument data.document.id, data.document.content

    jQuery.post newDocumentUrl, {}, newDocumentFunc, "json"

  loadDocument = ->

    url = "/documents/" + documentList.val() + "?make_current=true"
    synchronizing = false

    jQuery.getJSON url, (data) ->

      setDocument data.document.id, data.document.content
      synchronizing = true

  reloadDocument = ->

    if synchronizing

      url = "/documents/current/" + interviewId

      jQuery.getJSON url, (data) ->

        if synchronizing

          syncDelay = if previousData is data.document.content then 5000 else 1000
          setDocument data.document.id, data.document.content
          updateDocumentList(data.document.id) if parseInt(documentList.val()) isnt data.document.id

  saveDocument = ->

    if synchronizing

      url = "/documents/" + documentId + ".json"
      payload = {
        document: { content: interviewDocument.val() },
        _method: "PUT"
      }
      previousData = payload.document.content

      jQuery.post url, payload

  syncTimer = ->

    if previousData is interviewDocument.val()
      reloadDocument()
    else
      saveDocument()

    setTimeout syncTimer, syncDelay

  documentList.change loadDocument
  $("#new-document").click createDocument
  $("#save-document").click saveDocument
  syncTimer()
