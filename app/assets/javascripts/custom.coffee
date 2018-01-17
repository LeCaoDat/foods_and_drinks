ready = ->
  if $('body').attr('data-loaded') == 'T'
    return
  $('body').attr('data-loaded','T')
$(document).ready(ready)
$(document).on 'turbolinks:load', ->
  mega_menu = '0'
  @dec_quantity = ->
    result = document.getElementById('quantity');
    qty = result.value
    if(!isNaN( qty ) && qty > 1)
      result.value--
    return false
  @inc_quantity = (quantity) ->
    result = document.getElementById('quantity');
    qty = result.value
    if( !isNaN( qty ) && qty < quantity)
      result.value++
    return false
  @close_popup = ->
    document.getElementById('quick_view_popup-overlay').style.display = 'none'
    document.getElementById('quick_view_popup-wrap').style.display = 'none'
  $('.pagination a').attr('data-remote', 'true');
  $('.tp-banner').revolution(
    delay:9000,
    startwidth:1920,
    startheight:790,
    hideThumbs:10,
    navigationType:'bullet',
    navigationStyle:'preview1',
    hideArrowsOnMobile:'on',
    touchenabled:'on',
    onHoverStop:'on',
    spinner:'spinner4'
  )
