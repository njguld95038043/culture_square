import book1 from 'images/book1.jpg'
import book2 from 'images/book2.jpg'
import book3 from 'images/book3.jpg'
import book4 from 'images/book4.jpg'

$(document).on('turbolinks:load', function () {
    $('#vegas-body').vegas({
    slides: [
        { src: book1 },
        { src: book2 },
        { src: book3 },
        { src: book4 },
    ],
    transition: [ 'blur2' ],
    animation: 'kenburnsDown',
    delay: 10000,
    animationDuration: 10000,
  });
})
