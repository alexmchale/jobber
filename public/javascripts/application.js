(function() {
  var __slice = Array.prototype.slice;
  jQuery.fn.bufferInput = function(callback) {
    var history, input, pointer, processInput;
    history = [];
    pointer = 0;
    input = $(this);
    processInput = function(e) {
      var _a;
      if ((_a = e.keyCode) === 13) {
        history.push(input.val());
        pointer = history.length;
        callback(input.val());
        input.val("");
        return false;
      } else if (_a === 38) {
        if (pointer > 0) {
          pointer -= 1;
          input.val(history[pointer]);
        }
        return false;
      } else if (_a === 40) {
        if (pointer < history.length - 1) {
          pointer += 1;
          input.val(history[pointer]);
        } else {
          pointer = history.length;
          input.val("");
        }
        return false;
      } else {
        return true;
      }
    };
    input.keydown(processInput);
    return $(this);
  };
  jQuery.fn.highlight = function() {
    var e;
    e = $(this);
    e.focus(function() {
      e.removeClass("inactive");
      return e.addClass("active");
    });
    e.blur(function() {
      e.removeClass("active");
      return e.addClass("inactive");
    });
    e.addClass("inactive");
    return e;
  };
  window.curry = function(func) {
    var params1;
    params1 = __slice.call(arguments, 1);
    return function() {
      var params2;
      params2 = __slice.call(arguments, 0);
      return func.apply(this, params1.concat(params2));
    };
  };
})();
