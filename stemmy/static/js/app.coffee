events = "change keyup keydown keypress paste drop"

wordCount = (s) ->
  # Check for only whitespace characters
  if /^\s*$/.test s
    return 0

  # Exclude start and end white-space
  s = s.replace /(^\s*)|(\s*$)/gi, ''
  # Replace two or more spaces with one
  s = s.replace /[ ]{2,}/gi, ' '
  # Exclude newline with a start spacing
  s = s.replace /\n /gi, '\n'
  s = s.replace /\n+/gi, '\n'

  s.split /\ |\n/
    .length

countWords = ->
  source = $("textarea[name='source']").val()

  # Count words
  count = wordCount source || ""

  # Update word count element
  $("#word-count").html count + if count is 1 then " word" else " words"

stemWords = ->
  $.ajax
    url: "/stem"
    data:
      source: $("textarea[name='source']").val()
    success: (data, status, response) ->
      $("#result").html data
    error: ->
      $("#result").html "Error"

ready = ->
  countWords()
  $("textarea[name='source']").on events, ->
    stemWords()
    countWords()

$(document).ready ready
$(document).on "page:load", ready
