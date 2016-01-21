# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

setHeiHeight = ->
  offset = $('#footer').offset()
  yFooter = offset.top
  yWindow = $(window).height()
  if (yFooter + 137 ) < yWindow
    y = yWindow - yFooter - 137
    mT = parseInt($('#footer').css('margin-top'))
    $('#footer').css('margin-top': mT + y )

$ ->
  $(window).resize( setHeiHeight );
  setHeiHeight()