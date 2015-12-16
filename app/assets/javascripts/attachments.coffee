# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

destroy_attach = ->
  $('.destroy-attach-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    attach_id = $(this).data('attachId')
    $('li#attach-' + attach_id).remove()

$ ->

$(document).on "page:update", ->
  destroy_attach()
