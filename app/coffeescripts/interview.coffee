$(document).ready ->

  templateList: $("#template")
  documentList: $("#document")
  interviewDocument: $("#interview-document")

  interviewId: $("#interview-id").val()

  updateDocumentList: (selectedDocumentId) ->
    documentsUrl: "/documents?interview_id=" + interviewId
    jQuery.getJSON documentsUrl, (datas) ->
      options: ""
      for data in datas
        doc: data.document
        sel: if doc.id is selectedDocumentId then ' selected="selected"' else ''
        options += '<option value="' + doc.id + '"' + sel + '>' + doc.name + '</option>'
      documentList.html options

  $("#new-document").click ->

    templateId: templateList.val()

    newDocumentUrl: "/documents"
    newDocumentUrl += "?interview_id=" + interviewId
    newDocumentUrl += "&template_id=" + templateId

    newDocumentFunc: (data) ->
      newDocumentId: data.document.id
      interviewDocument.html data.document.content
      updateDocumentList(newDocumentId)

    jQuery.post newDocumentUrl, {}, newDocumentFunc, "json"

  $("#load-document").click ->

    documentId: documentList.val()
    url: "/documents/" + documentId + "?make_current=true"

    jQuery.getJSON url, (data) ->
      interviewDocument.html data.document.content

  $("#save-document").click ->

    documentId: documentList.val()
    url: "/documents/" + documentId
    payload: {
      document: { content: interviewDocument.val() },
      _method: "PUT"
    }

    jQuery.post url, payload
