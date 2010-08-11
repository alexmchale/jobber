(function(){
  $(document).ready(function() {
    var createDocument, documentId, documentList, interviewDocument, interviewId, loadDocument, previousData, reloadDocument, saveDocument, setDocument, syncDelay, syncTimer, synchronizing, templateList, updateDocumentList;
    templateList = $("#template");
    documentList = $("#document");
    interviewDocument = $("#interview-document");
    interviewId = $("#interview-id").val();
    previousData = interviewDocument.val();
    documentId = documentList.val();
    syncDelay = 500;
    synchronizing = true;
    setDocument = function setDocument(id, content) {
      if (id !== undefined) {
        documentId = id;
      }
      previousData = content;
      return interviewDocument.html(content);
    };
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
        updateDocumentList(data.document.id);
        return setDocument(data.document.id, data.document.content);
      };
      return jQuery.post(newDocumentUrl, {
      }, newDocumentFunc, "json");
    };
    loadDocument = function loadDocument() {
      var url;
      url = "/documents/" + documentList.val() + "?make_current=true";
      synchronizing = false;
      return jQuery.getJSON(url, function(data) {
        setDocument(data.document.id, data.document.content);
        return synchronizing = true;
      });
    };
    reloadDocument = function reloadDocument() {
      var url;
      if (synchronizing) {
        url = "/documents/" + documentId;
        return jQuery.getJSON(url, function(data) {
          return setDocument(undefined, data.document.content);
        });
      }
    };
    saveDocument = function saveDocument() {
      var payload, url;
      if (synchronizing) {
        url = "/documents/" + documentId + ".json";
        payload = {
          document: {
            content: interviewDocument.val()
          },
          _method: "PUT"
        };
        previousData = payload.document.content;
        return jQuery.post(url, payload);
      }
    };
    syncTimer = function syncTimer() {
      previousData === interviewDocument.val() ? reloadDocument() : saveDocument();
      return setTimeout(syncTimer, syncDelay);
    };
    $("#new-document").click(createDocument);
    $("#load-document").click(loadDocument);
    $("#save-document").click(saveDocument);
    return syncTimer();
  });
})();