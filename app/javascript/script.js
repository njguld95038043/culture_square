$(document).on('turbolinks:load', function () {
  $("#theTarget").skippr({
    transition : 'slide',
    speed : 1000,
    easing : 'easeOutQuart',
    navType : 'block',
    childrenElementType : 'div',
    arrows : true,
    autoPlay : true,
    autoPlayDuration : 3000,
    keyboardOnAlways : true,
    hidePrevious : false
  });
});

$(document).on('turbolinks:load', function () {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 500);
    event.preventDefault();
  });
});

$(document).on('turbolinks:load', function () {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    event.preventDefault();
  });
});