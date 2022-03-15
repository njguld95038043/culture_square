import book1 from 'images/book1.jpg'
import book2 from 'images/book2.jpg'
import book3 from 'images/book3.jpg'
import book4 from 'images/book4.jpg'

$(function() {
    $('#vegas-body').vegas({
    slides: [
        { src: book1 },
        { src: book2 },
        { src: book3 },
        { src: book4 },

    ]
  });
})
