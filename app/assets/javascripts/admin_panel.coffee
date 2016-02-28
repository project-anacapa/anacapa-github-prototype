# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    console.log "ready"

    toggle = (elem, url, role, toggle_to) ->
        $.ajax
            url: url
            type: "POST"
            data: {toggle_to: toggle_to}
            success: (data) ->
                if toggle_to
                    alert("enabled " + role + " privileges " + JSON.stringify(data))
                else
                    alert("disabled " + role + " privileges " + JSON.stringify(data))
            error: (err) ->
                elem.attr("checked", !toggle_to)
                alert("There were problems " + role + " toggling privileges. Try again later")

    $('.admin_toggle').change ->
        toggle_to = $(this).is ":checked"
        url = $(this).data "url"
        toggle $(this), url, "admin", toggle_to

    $('.instructor_toggle').change ->
        toggle_to = $(this).is ":checked"
        url = $(this).data "url"
        toggle $(this), url, "instructor", toggle_to

$(document).ready(ready)
$(document).on('page:load', ready)