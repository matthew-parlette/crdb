// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap.min
//= require jquery_ujs
//= require jquery.ui.all
//= require turbolinks
//= require jquery.modal
//= require bootstrap-datepicker
//= require pomodoro
//= require_tree .

function hideAlerts() {
    $("#alert").alert('close')
    $("#notice").alert('close')
}

window.setTimeout(function () {
    hideAlerts();
}, 5000);

// From https://github.com/admsev/jquery-play-sound
(function($){

  $.extend({
    playSound: function(){
      return $("<embed src='"+arguments[0]+".mp3' hidden='true' autostart='true' loop='false' class='playSound'>" + "<audio autoplay='autoplay' style='display:none;' controls='controls'><source src='"+arguments[0]+".mp3' /></audio>").appendTo('#pomodoro');
    }
  });

})(jQuery);