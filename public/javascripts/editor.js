(function() {
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
    setDocument = function(id, content) {
      ({
        documentId: (function() {
          if (id !== undefined) {
            return id;
          }
        })(),
        previousData: content
      });
      return interviewDocument.html(content);
    };
    updateDocumentList = function(selectedDocumentId) {
      var documentsUrl;
      documentsUrl = "/documents?interview_id=" + interviewId;
      return jQuery.getJSON(documentsUrl, function(datas) {
        var _a, _b, _c, data, doc, options, sel;
        options = "";
        _b = datas;
        for (_a = 0, _c = _b.length; _a < _c; _a++) {
          data = _b[_a];
          doc = data.document;
          sel = doc.id === selectedDocumentId ? ' selected="selected"' : '';
          options += '<option value="' + doc.id + '"' + sel + '>' + doc.name + '</option>';
        }
        return documentList.html(options);
      });
    };
    createDocument = function() {
      var newDocumentFunc, newDocumentUrl, templateId;
      templateId = templateList.val();
      newDocumentUrl = "/documents";
      newDocumentUrl += "?interview_id=" + interviewId;
      newDocumentUrl += "&template_id=" + templateId;
      newDocumentFunc = function(data) {
        updateDocumentList(data.document.id);
        return setDocument(data.document.id, data.document.content);
      };
      return jQuery.post(newDocumentUrl, {}, newDocumentFunc, "json");
    };
    loadDocument = function() {
      var url;
      url = "/documents/" + documentList.val() + "?make_current=true";
      synchronizing = false;
      return jQuery.getJSON(url, function(data) {
        setDocument(data.document.id, data.document.content);
        return (synchronizing = true);
      });
    };
    reloadDocument = function() {
      var url;
      if (synchronizing) {
        url = "/documents/current/" + interviewId;
        return jQuery.getJSON(url, function(data) {
          if (synchronizing) {
            setDocument(data.document.id, data.document.content);
            if (parseInt(documentList.val()) !== data.document.id) {
              return updateDocumentList(data.document.id);
            }
          }
        });
      }
    };
    saveDocument = function() {
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
    syncTimer = function() {
      if (previousData === interviewDocument.val()) {
        reloadDocument();
      } else {
        saveDocument();
      };
      return setTimeout(syncTimer, syncDelay);
    };
    documentList.change(loadDocument);
    $("#new-document").click(createDocument);
    $("#save-document").click(saveDocument);
    return syncTimer();
  });
})();
