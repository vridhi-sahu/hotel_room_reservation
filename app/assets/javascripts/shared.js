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
      selectLongPressDelay:0.0001,

      eventResize: function (event, delta, revertFunc) {
        var start_date = event.start.format()
        var end_date = event.end.format()
        var title = event.title
        $.ajax({
           url: "/events/"+ event.id,
           type: "put",
           data: {
            start_date: start_date, end_date: end_date, title: title
           }
        });
      },

      select: function (start_date, end_date, allDay) {
        var start_date = start_date.format()
        var end_date = end_date.format()
        $.ajax({
           url: "/events/new",
           type: "get",
           data: {
            start_date: start_date, end_date: end_date
           }
        });
      },

      eventClick: function(calEvent, jsEvent, view) {
        var ev_id= calEvent.id
        var event_title= calEvent.title
        $.ajax({
           url: "/events/"+ev_id,
           type: "get",
           data: {
            id: ev_id, title: event_title
           }
        });
      }
    });
  }

});
