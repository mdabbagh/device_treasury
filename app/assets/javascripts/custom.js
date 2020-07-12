$(document).ready(function() {
  // get current URL path and assign 'active' class
  setActiveNavStyle();
});

function setActiveNavStyle() {
  var pathname = window.location.pathname;
  $(".nav-item.active").removeClass("active");
  if (pathname == "/") {
    $('.nav-item a[href="/"]').parent().addClass("active");
  } else if(pathname == "/login") {
    $('.nav-item a[href="/login"]').parent().addClass("active");
  } else {
    $('.nav-item a[href*="' + pathname + '"]')
      .parent()
      .addClass("active");
  }
}