events = "change keyup keydown keypress paste drop"
algorithm = "porter2"

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
      algorithm: algorithm
      source: $("textarea[name='source']").val()
    success: (data, status, response) ->
      $("#result").html data
    error: ->
      $("#result").html "Error"

algorithmLinkClick = (event) ->
  # Update algorithm
  algorithm = event.data.algorithm

  # Stem words with new algorithm
  stemWords()

  # Update active link
  $("a").removeClass("active");
  $("##{algorithm}-algorithm").addClass("active");

ready = ->
  countWords()

  # Stem and count words on every change of source text
  $("textarea[name='source']").on events, ->
    stemWords()
    countWords()

  # Bind click event handlers to algorithm links
  $("#lovins-algorithm").click algorithm: "lovins", algorithmLinkClick
  $("#paicehusk-algorithm").click algorithm: "paicehusk", algorithmLinkClick
  $("#porter-algorithm").click algorithm: "porter", algorithmLinkClick
  $("#porter2-algorithm").click algorithm: "porter2", algorithmLinkClick

$(document).ready ready
$(document).on "page:load", ready
