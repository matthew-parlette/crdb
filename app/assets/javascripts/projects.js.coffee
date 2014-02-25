# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "click", ".dropdown-menu li a", ->
  #alert "url:" + $(this).attr("data-url") + ", status: " + $(this).text()
  $.ajax
    url: $(this).attr("data-url"),
    type: 'PATCH',
    dataType: 'json',
    data: { project: { status: $(this).text() } }
    success: ->
      #alert "updated project status"
