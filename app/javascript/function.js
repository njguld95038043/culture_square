import book5 from 'images/book5.jpg'
import book6 from 'images/book6.jpg'
import book7 from 'images/book7.jpg'
import book8 from 'images/book8.jpg'

$(document).on('turbolinks:load', function () {
    $('#vegas-body').vegas({
    slides: [
        { src: book5 },
        { src: book6 },
        { src: book7 },
        { src: book8 },
    ],
    transition: [ 'blur2' ],
    animation: 'kenburnsUpRight',
    delay: 10000,
    animationDuration: 10000,
  });
})
