/* <![CDATA[ */
var mega_menu = '0';
/* ]]> */
$(document).ready(function() {
  $('.tp-banner').revolution(
  {
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
  });
  $('.pagination a').attr('data-remote', 'true');
});
function dec_quality(){
  var result = document.getElementById('qty');
  var qty = result.value;
  if(!isNaN( qty ) && qty > 1) result.value--;
  return false;
};
function inc_quality(quality){
  var result = document.getElementById('qty');
  var qty = result.value;
  if( !isNaN( qty ) && qty < quality) result.value++;
  return false;
}
function close_popup(){
  document.getElementById('quick_view_popup-overlay').style.display = 'none';
  document.getElementById('quick_view_popup-wrap').style.display = 'none';
}
