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
  return

$(document).ready(ready)
$(document).on('page:load', ready)
