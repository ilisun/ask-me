# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


renderNewForm = ->
  $('.new-comment-link').click (e) ->
    e.preventDefault()
    $(this).bind 'ajax:success', (e,  data, status, xhr) ->
      obj = $.parseJSON(xhr.responseText)
      comment_new_template = HandlebarsTemplates['comments/form']
        parent_id: obj.comment.commentable_id
        parent_type: commentableType(obj.comment.commentable_type)
      if obj.comment.commentable_type == 'Answer'
        $("#answer-edit-" + obj.comment.commentable_id).html(comment_new_template)
      else $("#question-comment").html(comment_new_template)

renderComment = ->
  $('form.new_comment').bind 'ajax:success', (e, data, status, xhr) ->
    obj = $.parseJSON(xhr.responseText)
    current_user_id = $('.footer-data').data('userId')
    comment_template = HandlebarsTemplates['comments/show']
      comment: obj.comment
      time: addTimeAgo(obj.comment.created_at)
      thisUserComment: current_user_id == obj.comment.user_id
    $('#new-comments-' + obj.comment.commentable_id).append(comment_template)
    $('form.new_comment').replaceWith()
    renderFlashMessage('Your comment is successfully created.', "info")
  .bind 'ajax:error', (e, xhr, status, error) ->
    msg = $.parseJSON(xhr.responseText)
    renderFlashMessage(msg, "danger", error)

deleteComment = ->
  $('.destroy-comment-link').click (e) ->
    e.preventDefault()
    $(this).bind 'ajax:success', (e,  data, status, xhr) ->
      obj = $.parseJSON(xhr.responseText)
      $('ul#comment-' + obj.comment.id).replaceWith()
      renderFlashMessage('Your comment is successfully deleted.', "info")
    .bind 'ajax:error', (e, xhr, status, error) ->
      msg = $.parseJSON(xhr.responseText)
      renderFlashMessage(msg, "danger", error)

closeNewForm = ->
  $('.close-new-comment').click (e) ->
    $('form.new_comment').replaceWith()

commentableType = (obj) ->
  return type = obj.toLowerCase() + 's'

window.renderFlashMessage = (message, type, status) ->
  if status == 'Unauthorized'
    msg = message.error
  else if status == 'Unprocessable Entity'
    msg = 'ERROR: ' + message.errors.body
  else msg = message
  flash_template = HandlebarsTemplates['flash_messages']
    message: msg
    type: type
  $('.alert').hide()
  $('.body').prepend(flash_template)

window.addTimeAgo = (time) ->
  jQuery.timeago.settings.lang = "ru"
  ta = jQuery.timeago(time)


$ ->

$(document).on "page:update", ->
  renderNewForm()
  renderComment()
  closeNewForm()
  deleteComment()

$(document).on "page:change", ->


