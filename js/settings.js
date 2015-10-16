$(document).ready(function(){
  // Slider
  $('.slider').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 2000,
    prevArrow: false,
    nextArrow: false,
    responsive: 
    [ { breakpoint: 1024,
        settings: {
          slidesToShow: 3,
          slidesToScroll: 3,
          infinite: true,
          dots: true
      } },
      { breakpoint: 600,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 2
      } },
      { breakpoint: 480,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1
      } } ]
  });
  // Smooth Wheel
  $("body").smoothWheel();
});

