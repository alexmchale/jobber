# Causes the given input field to be buffered and respond to
# up/down arrows as well as the enter key.  The callback is
# fired when the enter key is pressed and given a value of the
# text.
jQuery.fn.bufferInput = (callback) ->

  history = []
  pointer = 0
  input = $(this)

  processInput = (e) ->

    switch e.keyCode

      when 13 # Enter
        history.push input.val()
        pointer = history.length
        callback input.val()
        input.val ""
        false

      when 38 # Up arrow
        if pointer > 0
          pointer -= 1
          input.val history[pointer]
        false

      when 40 # Down arrow
        if pointer < history.length - 1
          pointer += 1
          input.val history[pointer]
        else
          pointer = history.length
          input.val ""
        false

      else
        true

  input.keydown processInput

  $(this)

window.curry = (func, params1...) ->
  (params2...) -> func(params1..., params2...)
