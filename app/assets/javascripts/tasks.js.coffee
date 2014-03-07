# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  ###
  task list
  ###
  $ ->
    $(".list-group.checked-list-box .list-group-item").each ->
      
      # Settings
      
      # Event Handlers
      
      
      # Actions
      updateDisplay = ->
        isChecked = $checkbox.is(":checked")
        
        # Set the button's state
        $widget.data "state", (if (isChecked) then "on" else "off")
        
        # Set the button's icon
        $widget.find(".state-icon").removeClass().addClass "state-icon " + settings[$widget.data("state")].icon
        
        # Update the button's color
        if isChecked
          $widget.addClass style + color + " active"
        else
          $widget.removeClass style + color + " active"
        return
      
      # Initialization
      init = ->
        $checkbox.prop "checked", not $checkbox.is(":checked")  if $widget.data("checked") is true
        updateDisplay()
        
        # Inject the icon if applicable
        $widget.prepend "<span class=\"state-icon " + settings[$widget.data("state")].icon + "\"></span>"  if $widget.find(".state-icon").length is 0
        return
      $widget = $(this)
      $checkbox = $("<input type=\"checkbox\" class=\"hidden\" />")
      color = ((if $widget.data("color") then $widget.data("color") else "primary"))
      style = ((if $widget.data("style") is "button" then "btn-" else "list-group-item-"))
      settings =
        on:
          icon: "glyphicon glyphicon-check"

        off:
          icon: "glyphicon glyphicon-unchecked"

      $widget.css "cursor", "pointer"
      $widget.append $checkbox
      $widget.on "click", ->
        $checkbox.prop "checked", not $checkbox.is(":checked")
        $checkbox.triggerHandler "change"
        $widget.triggerHandler "update"
        updateDisplay()
        return

      $checkbox.on "change", ->
        updateDisplay()
        return
      
      $widget.on "update", ->
        #alert "updating " + $widget.attr("id") + " to " + $checkbox.is(":checked")
        $.ajax
          url: $widget.attr("data-url"),
          type: 'PATCH',
          dataType: 'json',
          data: { task: { completed: $checkbox.is(":checked") } }
          success: ->
            #alert "updated project status"
        return

      init()
      return

    $("#get-checked-data").on "click", (event) ->
      event.preventDefault()
      checkedItems = {}
      counter = 0
      $("#check-list-box li.active").each (idx, li) ->
        checkedItems[counter] = $(li).text()
        counter++
        return

      $("#display-json").html JSON.stringify(checkedItems, null, "\t")
      return

    return

$(document).ready(ready)
$(document).on('page:load', ready)
