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

getLocation = ->
  if (navigator.geolocation)
    navigator.geolocation.getCurrentPosition showPosition

showPosition = (position)->
  $("#searchLatitude").val position.coords.latitude
  $("#searchLongitude").val position.coords.longitude
  $("#searchGeocode").attr "disabled", false

getLocation()

loadResults = ->
  query = $("#searchField").val()
  latitude = $("#searchLatitude").val()
  longitude = $("#searchLongitude").val()
  geocode = $("#searchGeocode").val()
  if !!query
    $.ajax
      url: "/search"
      type: "POST"
      data:
        query: query
        geocode: geocode
        latitude: latitude
        longitude: longitude
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
