(function() {
  $(document).ready(function() {
    var createDocument, dmp, documentId, documentList, interviewDocument, interviewId, loadDocument, merge, patchLevel, serverData, syncDelay, syncTimer, synchronizing, templateList, updateDocument, updateDocumentList;
    templateList = $("#template");
    documentList = $("#document");
    interviewDocument = $("#interview-document");
    interviewId = $("#interview-id").val();
    serverData = interviewDocument.val();
    documentId = documentList.val();
    syncDelay = 500;
    synchronizing = true;
    dmp = new diff_match_patch();
    patchLevel = $("#patch-level").val();
    updateDocumentList = function() {
      var documentsUrl;
      documentsUrl = ("/documents?interview_id=" + (interviewId));
      return jQuery.getJSON(documentsUrl, function(datas) {
        var _a, _b, _c, _d, data, doc, options, sel;
        options = (function() {
          _a = []; _c = datas;
          for (_b = 0, _d = _c.length; _b < _d; _b++) {
            data = _c[_b];
            _a.push((function() {
              doc = data.document;
              sel = doc.id === documentId ? ' selected="selected"' : '';
              return "<option value='" + (doc.id) + "'" + (sel) + ">" + (doc.name) + "</option>";
            })());
          }
          return _a;
        })();
        return documentList.html(options.join(""));
      });
    };
    createDocument = function() {
      var context, newDocumentFunc;
      context = {
        interview_id: interviewId,
        template_id: templateList.val()
      };
      newDocumentFunc = function(data) {
        updateDocumentList(data.document.id);
        return setDocument(data.document.id, data.document.content);
      };
      return jQuery.post("/documents", context, newDocumentFunc, "json");
    };
    loadDocument = function() {
      var url;
      setDocument(documentList.val(), "");
      patchLevel = 0;
      url = "/documents/" + documentList.val() + "?make_current=true";
      synchronizing = false;
      return jQuery.getJSON(url, function(data) {
        setDocument(data.document.id, data.document.content);
        return (synchronizing = true);
      });
    };
    updateDocument = function(destinationData) {
      var _a, _b, _c, _d, cursor, diff, offset, text, type;
      diff = dmp.diff_main(interviewDocument.val(), destinationData);
      cursor = interviewDocument.getSelection() || {
        start: 0,
        end: 0
      };
      offset = 0;
      interviewDocument.setSelection(0, 0);
      _b = diff;
      for (_a = 0, _d = _b.length; _a < _d; _a++) {
        _c = _b[_a];
        type = _c[0];
        text = _c[1];
        if (type === (-1)) {
          interviewDocument.setSelection(offset, offset + text.length);
          interviewDocument.replaceSelection("");
          if (offset < cursor.start) {
            cursor.start -= text.length;
            cursor.end -= text.length;
          }
        } else if (type === 0) {
          offset += text.length;
        } else if (type === (+1)) {
          interviewDocument.setCaretPos(offset + 1);
          interviewDocument.insertAtCaretPos(text);
          if (offset < cursor.start) {
            cursor.start += text.length;
            cursor.end += text.length;
          }
          offset += text.length;
        }
      }
      return interviewDocument.setSelection(cursor.start, cursor.end);
    };
    merge = function(data) {
      var d1, localData, p1, patch, r1;
      if ((patch = typeof data === "undefined" || data == undefined ? undefined : data.document_patch)) {
        localData = interviewDocument.val();
        if (patch.content !== localData) {
          d1 = dmp.diff_main(serverData, localData);
          p1 = dmp.patch_make(serverData, localData, d1);
          r1 = dmp.patch_apply(p1, patch.content);
          updateDocument(r1[0]);
        }
        serverData = patch.content;
        patchLevel = patch.id;
      } else {
        alert("clearing server info");
        serverData = "";
        patchLevel = 0;
      }
      return setTimeout(syncTimer, syncDelay);
    };
    syncTimer = function() {
      var context, localData, patchUrl;
      if (!(synchronizing)) {
        return null;
      }
      patchUrl = ("/documents/patch/" + (documentId));
      localData = interviewDocument.val();
      if (serverData !== localData) {
        context = {
          patch_id: patchLevel,
          content: localData
        };
        serverData = localData;
        return jQuery.post(patchUrl, context, merge, "json");
      } else {
        return jQuery.getJSON(patchUrl, merge);
      }
    };
    documentList.change(loadDocument);
    $("#new-document").click(createDocument);
    return syncTimer();
  });
})();
