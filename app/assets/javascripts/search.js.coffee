getHashVal = ->
  decodeURIComponent(getBareLocationHash())

getBareLocationHash = ->
  window.location.hash.replace(/^#/, "")

buildHashVal = (val)->
  encodeURIComponent(val)

setHashVal = (val)->
  if !likeHash val
    window.location.hash = buildHashVal val

likeHash = (val)->
  buildHashVal(val) == getHashVal()

loadResults = ->
  query = $("#searchField").val()
  if !!query
    $.ajax
      url: "/search"
      type: "POST"
      data:
        query: query
      complete: (response)->
        $('#results').html response.responseText
        setHashVal query
  else
    $('#results').html ""

$("#searchForm").submit (e)->
  loadResults()
  false

loadOldResults = ->
  $("#searchField").val getHashVal()
  loadResults()

loadOldResults()

window.onhashchange = loadOldResults
