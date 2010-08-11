$(document).ready ->

  templateList:      $("#template")
  documentList:      $("#document")
  interviewDocument: $("#interview-document")
  interviewId:       $("#interview-id").val()
  previousData:      interviewDocument.val()
  documentId:        documentList.val()
  syncDelay:         1000 # TODO: This should be adjusted intelligently in the future.

  updateDocumentList: (selectedDocumentId) ->

    documentsUrl: "/documents?interview_id=" + interviewId

    jQuery.getJSON documentsUrl, (datas) ->
      options: ""
      for data in datas
        doc: data.document
        sel: if doc.id is selectedDocumentId then ' selected="selected"' else ''
        options += '<option value="' + doc.id + '"' + sel + '>' + doc.name + '</option>'
      documentList.html options

  createDocument: ->

    templateId: templateList.val()

    newDocumentUrl: "/documents"
    newDocumentUrl += "?interview_id=" + interviewId
    newDocumentUrl += "&template_id=" + templateId

    newDocumentFunc: (data) ->
      newDocumentId: data.document.id
      interviewDocument.html data.document.content
      updateDocumentList newDocumentId
      documentId: newDocumentId

    jQuery.post newDocumentUrl, {}, newDocumentFunc, "json"

  loadDocument: (nextDocumentId) ->

    nextDocumentId: documentList.val() if nextDocumentId is undefined
    url: "/documents/" + nextDocumentId + "?make_current=true"

    jQuery.getJSON url, (data) ->
      interviewDocument.html data.document.content
      previousData: data.document.content
      documentId: data.document.id

  reloadDocument: ->

    loadDocument documentId

  saveDocument: ->

    documentId: documentList.val()
    url: "/documents/" + documentId + ".json"
    payload: {
      document: { content: interviewDocument.val() },
      _method: "PUT"
    }
    previousData: payload.document.content

    jQuery.post url, payload

  syncTimer: ->

    if previousData is interviewDocument.val()
      reloadDocument()
    else
      saveDocument()

    setTimeout syncTimer, syncDelay

  $("#new-document").click createDocument
  $("#load-document").click loadDocument
  $("#save-document").click saveDocument
  syncTimer()
