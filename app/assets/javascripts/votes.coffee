# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


renderVotes = ->
  $('.votes-button').click (e) ->
    e.preventDefault()
    $(this).bind 'ajax:success', (e,  data, status, xhr) ->
      obj = $.parseJSON(xhr.responseText)
      path = "vote-" + obj.vote.votable_type.toLowerCase() + "-" + obj.vote.votable_id
      vote_form = HandlebarsTemplates['votes/vote']
        value: obj.vote.votes_sum
        vote_path: path
      $("#" + path).replaceWith(vote_form)
      if obj.vote.value >0
        renderFlashMessage('You voted for this issue.', "success")
      else renderFlashMessage('You voted against the issue.', "info")
    .bind 'ajax:error', (e, xhr, status, error) ->
      msg = $.parseJSON(xhr.responseText)
      renderFlashMessage(msg, "danger", error)


$ ->

$(document).on "page:update", ->
  renderVotes()

$(document).on "page:change", ->

