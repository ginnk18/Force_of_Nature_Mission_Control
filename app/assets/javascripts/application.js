// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs
//= require moment
//= require fullcalendar
//= require fullcalendar/gcal
//= require bootstrap-datepicker
//= require chosen-jquery
//= require_tree .


$(document).ready(function() {

   // page is now ready, initialize the calendar...

   $('#calendar').fullCalendar({
                    googleCalendarApiKey: 'AIzaSyBpRXLypD_qp0wQyqLMD351LGAl3dTCyzs',
                    events: {
                        googleCalendarId: 'thissectionclosedcc@gmail.com'
                    },
                    eventClick: function(calEvent, jsEvent, view) {
                        // change the border color just for fun
                        $(this).css('border-color', 'red');
                        //window.location.href = `http://localhost:3000/eventscal/${calEvent.id}`;
                        $('#eventShow').modal('toggle');
                        setTimeout( function(){
                        $( '#ModalLabel' ).html("Event: " + calEvent.title);
                        $( '#starttime' ).html("Start Time: " + calEvent.start._d)
                        $( '#endtime' ).html("End Time: " + calEvent.end._d);
                        $('#location').html("Location: " + calEvent.location);;


                        $('#moredetails').on('click', function(event){
                        window.location.href = 'http://fonmissioncontrol.herokuapp.com/eventscal' + calEvent.id;

                        });
                        $('#eventsignupform').on('submit', function(event) {
                        event.preventDefault();
                        var email = event.target.querySelector('#email_email').value;
                        fetch('/newsignup/' + calEvent.id, { method: 'post',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
                        },
                        body: email  }).then(function(res) { return res.json()}).then(function(data) { return $('#message').html(data.message)});
                        });
                        },10 )
                        return false;
                    }
                });


              


});
