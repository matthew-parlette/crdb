# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###
update status from workflow buttons
###
$(document).on "click", ".btn-workflow", ->
  #abort if data-url is not defined
  return if $(this).attr("data-url") == undefined
  $.ajax
    url: $(this).attr("data-url"),
    type: 'PATCH',
    dataType: 'json',
    data: { project: { status: $(this).attr("data-status") } }
    success: ->
      #alert "updated project status"
      location.reload()
    error: ->
      #error will be shown in alert div
      location.reload()

###
update status selection via ajax
###
$(document).on "click", ".dropdown-menu li a", ->
  #abort if data-url is not defined
  return if $(this).attr("data-url") == undefined
  $.ajax
    url: $(this).attr("data-url"),
    type: 'PATCH',
    dataType: 'json',
    data: { project: { status: $(this).text() } }
    success: ->
      #alert "updated project status"
      location.reload()
    error: ->
      #error will be shown in alert div
      location.reload()

ready = ->
  return
$(document).on "click", ".project-panel .clickable", (e) ->
  $icon = $(this).find("i")
  if $icon.hasClass("glyphicon-plus")
    $icon.removeClass("glyphicon-plus").addClass "glyphicon-minus"
  else
    $icon.removeClass("glyphicon-minus").addClass "glyphicon-plus"

$(document).ready(ready)
$(document).on('page:load', ready)