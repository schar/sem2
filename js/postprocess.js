$(document).ready(function(){
  $('table').addClass('f7 f6-ns w-100 mw8 center').attr('cellspacing','0').removeAttr('style');
  $('td').removeAttr('align').addClass('pa2');
  $('th').addClass('fw6 tl pa2').removeAttr('align');
  $('tr').addClass('striped--near-white dim');
  $('#content a').addClass('link dim gray');
  $('colgroup').remove();
  $('thead, tbody, table p').contents().unwrap();
  $('p').each(function() {
    var $this = $(this);
    if($this.html().replace(/\s|&nbsp;/g, '').length == 0)
        $this.remove();
  });;
  $('table li').addClass('pt1');
  $('.references').addClass('f7');
  $('.references p').addClass('mb3 mt0');
  var unit = 5;
  $('tr:nth-of-type('+unit+')').addClass('b hot-pink');
});
