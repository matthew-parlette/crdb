# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Filtered table, copied from http://bootsnipp.com/snippets/featured/panel-tables-with-filter

###
I don't recommend using this plugin on large tables, I just wrote it to make the demo useable. It will work fine for smaller tables
but will likely encounter performance issues on larger tables.

<input type="text" class="form-control" id="dev-table-filter" data-action="filter" data-filters="#dev-table" placeholder="Filter Developers" />
$(input-element).filterTable()

The important attributes are 'data-action="filter"' and 'data-filters="#table-selector"'
###
(->
  "use strict"
  $ = jQuery
  $.fn.extend filterTable: ->
    @each ->
      $(this).on "keyup", (e) ->
        $(".filterTable_no_results").remove()
        $this = $(this)
        search = $this.val().toLowerCase()
        target = $this.attr("data-filters")
        $target = $(target)
        $rows = $target.find("tbody tr")
        if search is ""
          $rows.show()
        else
          $rows.each ->
            $this = $(this)
            (if $this.text().toLowerCase().indexOf(search) is -1 then $this.hide() else $this.show())
            return

          if $target.find("tbody tr:visible").size() is 0
            col_count = $target.find("tr").first().find("td").size()
            no_results = $("<tr class=\"filterTable_no_results\"><td colspan=\"" + col_count + "\">No results found</td></tr>")
            $target.find("tbody").append no_results
        return

      return


  $("[data-action=\"filter\"]").filterTable()
  return
) jQuery

ready = ->
  # attach table filter plugin to inputs
  $("[data-action=\"filter\"]").filterTable()
  $("#projects-table-filter").focus()

  $("[data-toggle=\"tooltip\"]").tooltip()
  update_user_instructions()
  return

$(document).ready(ready)
$(document).on('page:load', ready)

$(document).on "click", ".projects-table-row", ->
  #alert $(this).attr("id")
  id_parts = $(this).attr("id").split "-"
  project_id = id_parts[1]
  console.log "adding " + project_id
  if $(this).hasClass("selected")
    # removing this row from the selection
    $(this).removeClass("selected")
    $(this).attr("data-action","remove")
  else
    # highlighting a previously de-selected row
    $(this).addClass("selected")
    $(this).attr("data-action","add")
  # update today's list with the changes
  $.ajax
    url: $(this).attr("data-url"),
    type: 'POST',
    dataType: 'json',
    data: { today: { projects: { action: $(this).attr("data-action"), id: $(this).attr("data-id") } } }
    success: (data) ->
      #alert "selected projects: " + data
      window.today = data
      update_user_instructions()
  return

update_user_instructions = ->
  #user-instructions-select-projects
  if today.projects.length > 0
    $("#user-instructions-select-projects").find("span").removeClass("glyphicon-remove-sign").addClass("glyphicon-ok-sign")
    $("#user-instructions-select-projects").find("span").removeClass("text-danger").addClass("text-success")
  else
    $("#user-instructions-select-projects").find("span").removeClass("glyphicon-ok-sign").addClass("glyphicon-remove-sign")
    $("#user-instructions-select-projects").find("span").removeClass("text-success").addClass("text-danger")
  return