$(function() {
  var time = 0;

  setInterval(timer, 1000);

  function timer() {
    time++;
    $("#time").val(time);
  }
});
