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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


var submitButton = document.querySelector("#submitButton")

submitButton.addEventListener('click', () => {

  var num = document.querySelector("#inputNumber").value
  var personInput = (Number(num) * 60) * 1000

  var deadline = new Date(Date.now() + personInput).getTime();
  var x = setInterval(function () {

    var now = new Date().getTime();

    var t = deadline - now;

    var hours = Math.floor((t % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((t % (1000 * 60)) / 1000);

    document.getElementById("hour").innerHTML = hours;
    document.getElementById("minute").innerHTML = minutes;
    document.getElementById("second").innerHTML = seconds;
    if (t < 0) {
      clearInterval(x);

      document.getElementById("demo").innerHTML = "TIME'S UP";
      document.getElementById("hour").innerHTML = '0';
      document.getElementById("minute").innerHTML = '0';
      document.getElementById("second").innerHTML = '0';
    }
  }, 1000);

})