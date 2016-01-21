# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Рендер ответа
renderAnswer = ->
  $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    obj = $.parseJSON(xhr.responseText)
    current_user_id = $('.footer-data').data('userId')
    answer_template = HandlebarsTemplates['answers/show']
      answer: obj.answer
    $('.answers').append(answer_template)
    answer_form = HandlebarsTemplates['answers/form']
      answer: obj.answer
      time: addTimeAgo(obj.answer.created_at)
      thisUserAnswer: current_user_id == obj.answer.user_id
      thisUserQuestion: current_user_id == obj.answer.question_user
    $('#answer-form-' + obj.answer.id).replaceWith(answer_form)
    renderExistingAttachments(obj.answer)
    $('#new_answer_body').val('')
    renderFlashMessage('Your answer successfully created.', "info")
  .bind 'ajax:error', (e, xhr, status, error) ->
    msg = $.parseJSON(xhr.responseText)
    renderFlashMessage(msg, "danger", error)

# Рендер формы редактирования ответа
renderEditForm = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).bind 'ajax:success', (e,  data, status, xhr) ->
      obj = $.parseJSON(xhr.responseText)
      answer_edit_template = HandlebarsTemplates['answers/edit']
        answer: obj.answer
      $("#answer-edit-" + obj.answer.id).html(answer_edit_template)
      $("#answer-add-attach-" + obj.answer.id).html HandlebarsTemplates['attachments/add_attachments']

# Редактирование ответа
editAnswer = ->
  $('form.edit_answer').bind 'ajax:success', (e,  data, status, xhr) ->
    obj = $.parseJSON(xhr.responseText)
    current_user_id = $('.footer-data').data('userId')
    answer_form = HandlebarsTemplates['answers/form']
      answer: obj.answer
      thisUserAnswer: current_user_id == obj.answer.user_id
    $('#answer-form-' + obj.answer.id).replaceWith(answer_form)
    renderExistingAttachments(obj.answer)
    $("form.edit_answer").replaceWith()
    renderFlashMessage('Your answer successfully fixed.', "info")
  .bind 'ajax:error', (e, xhr, status, error) ->
    msg = $.parseJSON(xhr.responseText)
    renderFlashMessage(msg, "danger", error)

# Удаление ответа
deleteAnswer = ->
  $('.destroy-answer-link').click (e) ->
    e.preventDefault()
    $(this).bind 'ajax:success', (e,  data, status, xhr) ->
      obj = $.parseJSON(xhr.responseText)
      $('article#article-' + obj.answer.id).replaceWith()
      renderFlashMessage('Your answer is successfully deleted.', "info")
    .bind 'ajax:error', (e, xhr, status, error) ->
      msg = $.parseJSON(xhr.responseText)
      renderFlashMessage(msg, "danger", error)

renderAcceptedAnswer = ->
  $('.accepted-answer').click (e) ->
    answer_id = $(this).data('answerId')
    accepted_form = HandlebarsTemplates['answers/accepted']
      answer: answer_id
    $('#accepted-' + answer_id).replaceWith(accepted_form)
    renderFlashMessage('You accepted this issue.', "success")

renderUnacceptedAnswer = ->
  $('.unaccepted-answer').click (e) ->
    answer_id = $(this).data('answerId')
    unaccepted_form = HandlebarsTemplates['answers/unaccepted']
      answer: answer_id
    $('#accepted-' + answer_id).replaceWith(unaccepted_form)
    renderFlashMessage('You unaccepted this issue.', "info")

closeEditForm = ->
  $('.close-edit-answer').click (e) ->
    $("form.edit_answer").replaceWith()

# ----------------------------------------------------------------------

renderExistingAttachments = (answer) ->
  addAttachmentsNames(answer.attachments ||= [])
  if answer.attachments.length > 0
    $("#answer-attach-" + answer.id).replaceWith HandlebarsTemplates['attachments/attachments']
      attachments: answer.attachments

addAttachmentsNames = (attachments) ->
  attachments.forEach (attachment) ->
    attachment.file.name = attachment.file.url.slice(attachment.file.url.lastIndexOf('/') + 1)

$ ->

$(document).on "page:update", ->
  renderEditForm()
  editAnswer()
  deleteAnswer()
  closeEditForm()
  renderAcceptedAnswer()
  renderUnacceptedAnswer()


$(document).on "page:change", ->
  renderAnswer()
