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

###
collapsable panels
###
$(document).on "click", ".panel-heading span.clickable", (e) ->
  $this = $(this)
  unless $this.hasClass("panel-collapsed")
    $this.parents(".panel").find(".panel-body").slideUp()
    $this.addClass "panel-collapsed"
    $this.find("i").removeClass("glyphicon-minus").addClass "glyphicon-plus"
  else
    $this.parents(".panel").find(".panel-body").slideDown()
    $this.removeClass "panel-collapsed"
    $this.find("i").removeClass("glyphicon-plus").addClass "glyphicon-minus"
  return

$(document).on "click", ".panel div.clickable", (e) ->
  $this = $(this)
  unless $this.hasClass("panel-collapsed")
    $this.parents(".panel").find(".panel-body").slideUp()
    $this.addClass "panel-collapsed"
    $this.find("i").removeClass("glyphicon-minus").addClass "glyphicon-plus"
  else
    $this.parents(".panel").find(".panel-body").slideDown()
    $this.removeClass "panel-collapsed"
    $this.find("i").removeClass("glyphicon-plus").addClass "glyphicon-minus"
  return

$(document).ready ->
  $(".panel div.clickable").click()
  return

$(document).on "page:load", ->
  $(".panel div.clickable").click()
  return
