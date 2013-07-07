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

enableGeocodeOptions = ->
  $("#searchGeocode").attr "disabled", false
  $("#searchRadius").attr "disabled", false

showPosition = (position)->
  $("#searchLatitude").val position.coords.latitude
  $("#searchLongitude").val position.coords.longitude
  enableGeocodeOptions()

getQuery = ->
  $("#searchField").val()

getLatitude = ->
  $("#searchLatitude").val()

getLongitude = ->
  $("#searchLongitude").val()

getGeocode = ->
  $("#searchGeocode").val()

getRadius = ->
  $("#searchRadius").val()

loadOldResults = ->
  $("#searchField").val getHashVal()
  loadResults()

loadResults = ->
  query = getQuery()
  if !!query
    $.ajax
      url: "/search"
      type: "POST"
      data:
        query: query
        geocode: getGeocode()
        latitude: getLatitude()
        longitude: getLongitude()
        radius: getRadius()
      complete: (response)->
        $('#results').html response.responseText
        setHashVal query
  else
    $('#results').html ""

$("#searchForm").submit (e)->
  loadResults()
  false

window.onhashchange = loadOldResults

getLocation()
loadOldResults()
