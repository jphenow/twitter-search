handler = (e)->
  $.ajax
    url: "/search"
    type: "POST"
    data:
      query: $("#searchField").val()
    complete: (response)->
      $('#results').html(response.responseText)
  false

$("#searchForm").submit handler
$("#searchSubmit").click handler
