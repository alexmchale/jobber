(function(){
  $(document).ready(function() {
    var createDocument, documentId, documentList, interviewDocument, interviewId, loadDocument, previousData, reloadDocument, saveDocument, syncTimer, templateList, updateDocumentList;
    templateList = $("#template");
    documentList = $("#document");
    interviewDocument = $("#interview-document");
    interviewId = $("#interview-id").val();
    previousData = interviewDocument.val();
    documentId = documentList.val();
    updateDocumentList = function updateDocumentList(selectedDocumentId) {
      var documentsUrl;
      documentsUrl = "/documents?interview_id=" + interviewId;
      return jQuery.getJSON(documentsUrl, function(datas) {
        var __a, __b, data, doc, options, sel;
        options = "";
        __a = datas;
        for (__b = 0; __b < __a.length; __b++) {
          data = __a[__b];
          doc = data.document;
          sel = doc.id === selectedDocumentId ? ' selected="selected"' : '';
          options += '<option value="' + doc.id + '"' + sel + '>' + doc.name + '</option>';
        }
        return documentList.html(options);
      });
    };
    createDocument = function createDocument() {
      var newDocumentFunc, newDocumentUrl, templateId;
      templateId = templateList.val();
      newDocumentUrl = "/documents";
      newDocumentUrl += "?interview_id=" + interviewId;
      newDocumentUrl += "&template_id=" + templateId;
      newDocumentFunc = function newDocumentFunc(data) {
        var newDocumentId;
        newDocumentId = data.document.id;
        interviewDocument.html(data.document.content);
        updateDocumentList(newDocumentId);
        return documentId = newDocumentId;
      };
      return jQuery.post(newDocumentUrl, {
      }, newDocumentFunc, "json");
    };
    loadDocument = function loadDocument(nextDocumentId) {
      var url;
      if (nextDocumentId === undefined) {
        nextDocumentId = documentList.val();
      }
      url = "/documents/" + nextDocumentId + "?make_current=true";
      return jQuery.getJSON(url, function(data) {
        interviewDocument.html(data.document.content);
        previousData = data.document.content;
        return documentId = data.document.id;
      });
    };
    reloadDocument = function reloadDocument() {
      return loadDocument(documentId);
    };
    saveDocument = function saveDocument() {
      var payload, url;
      documentId = documentList.val();
      url = "/documents/" + documentId + ".json";
      payload = {
        document: {
          content: interviewDocument.val()
        },
        _method: "PUT"
      };
      previousData = payload.document.content;
      return jQuery.post(url, payload);
    };
    syncTimer = function syncTimer() {
      return previousData === interviewDocument.val() ? reloadDocument() : saveDocument();
    };
    $("#new-document").click(createDocument);
    $("#load-document").click(loadDocument);
    $("#save-document").click(saveDocument);
    return setInterval(syncTimer, 2500);
  });
})();