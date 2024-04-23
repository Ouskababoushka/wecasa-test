import "jquery"
import "jquery_ujs"
import "popper"
import 'bootstrap/dist/js/bootstrap'
import 'bootstrap-icons/font/bootstrap-icons.css'
import 'bootstrap-datepicker'
import 'flatpickr';
import 'flatpickr/dist/flatpickr.min.css';

document.addEventListener('DOMContentLoaded', function() {
  flatpickr('.date', {
    // Flatpickr options
  });
});
