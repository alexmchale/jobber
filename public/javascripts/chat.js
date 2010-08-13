(function() {
  jQuery(document).ready(function() {
    return $("#public-in").bufferInput(function(txt) {
      return alert(txt);
    });
  });
})();
