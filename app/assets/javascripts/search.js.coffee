$("#searchSubmit").click (e)->
  $.ajax
    url: "/search"
    type: "POST"
    data:
      query: $("#searchField").val()
    complete: (response, status)->
      $('#results').html(response)
