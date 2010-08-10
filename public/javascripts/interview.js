(function(){
  $(document).ready(function() {
    var documentList, interviewDocument, interviewId, templateList, updateDocumentList;
    templateList = $("#template");
    documentList = $("#document");
    interviewDocument = $("#interview-document");
    interviewId = $("#interview-id").val();
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
    $("#new-document").click(function() {
      var newDocumentFunc, newDocumentUrl, templateId;
      templateId = templateList.val();
      newDocumentUrl = "/documents";
      newDocumentUrl += "?interview_id=" + interviewId;
      newDocumentUrl += "&template_id=" + templateId;
      newDocumentFunc = function newDocumentFunc(data) {
        var newDocumentId;
        newDocumentId = data.document.id;
        interviewDocument.html(data.document.content);
        return updateDocumentList(newDocumentId);
      };
      return jQuery.post(newDocumentUrl, {
      }, newDocumentFunc, "json");
    });
    $("#load-document").click(function() {
      var documentId, url;
      documentId = documentList.val();
      url = "/documents/" + documentId + "?make_current=true";
      return jQuery.getJSON(url, function(data) {
        return interviewDocument.html(data.document.content);
      });
    });
    return $("#save-document").click(function() {
      var documentId, payload, url;
      documentId = documentList.val();
      url = "/documents/" + documentId;
      payload = {
        document: {
          content: interviewDocument.val()
        },
        _method: "PUT"
      };
      return jQuery.post(url, payload);
    });
  });
})();