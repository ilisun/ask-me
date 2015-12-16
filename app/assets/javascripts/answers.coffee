# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

update_answer = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

close_update_answer = ->
  $('.close-edit-answer').click (e) ->
    e.preventDefault()
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).hide()
    $('.edit-answer-link').show()

destroy_answer = ->
  $('.destroy-answer-link').click (e) ->
    e.preventDefault()
    answer_id = $(this).data('answerId')
    $('article#article-' + answer_id).remove()

$ ->

$(document).on "page:update", ->
  update_answer()
  close_update_answer()
  destroy_answer()
