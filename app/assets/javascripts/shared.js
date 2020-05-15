$(document).ready(function() {
  $('.datepicker').datepicker()

  if ( $('#calendar').length == 1 ) {
    var events = gon.bookings
    $('#calendar').fullCalendar('render')
    $('#calendar').fullCalendar({
      eventSources: [
        {
          events: events,
          color: 'green',
          textColor: 'white'
        }
      ],

      selectable: true,
      selectHelper: true,
      selectLongPressDelay:0.0001
    });
  }

});
